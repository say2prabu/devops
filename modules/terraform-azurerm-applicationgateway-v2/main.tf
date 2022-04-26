# locals

locals {
  public_frontend_ip_configuration_name  = "${var.appgw_name}-feip-public"
  private_frontend_ip_configuration_name = "${var.appgw_name}-feip-private"
  gateway_ip_configuration_name          = "${var.appgw_name}-gwipconfig"
}

#
# Application Gateway Subnet and resource group
#

data "azurerm_subnet" "appgwsubnet" {
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.vnet_rsg_name
}

data "azurerm_resource_group" "rsg" {
  name = var.appgw_rsg
}

data "azurerm_key_vault" "kv" {
  name                = var.kevault_name
  resource_group_name = var.keyvault_rsg
}

data "azurerm_client_config" "current" {}

#
# Create User Managed Identity
# User Assigned Managed identity is used to retrieve certificates from Key Vault.

resource "azurerm_user_assigned_identity" "msi" {
  resource_group_name = var.appgw_rsg
  location            = var.appgw_location
  name                = "${var.appgw_name}-msi"
}

resource "azurerm_role_assignment" "msi" {
  scope                = azurerm_application_gateway.appgw.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.msi.principal_id
}

resource "azurerm_role_assignment" "rsg" {
  scope                = data.azurerm_resource_group.rsg.id
  role_definition_name = "Reader"
  principal_id         = azurerm_user_assigned_identity.msi.principal_id
}

resource "azurerm_key_vault_access_policy" "msi" {
  key_vault_id = data.azurerm_key_vault.kv.id
  object_id    = azurerm_user_assigned_identity.msi.principal_id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  certificate_permissions = [
    "Get",
    "List"
  ]
  secret_permissions = [
    "Get",
    "List"
  ]
}

# 
# Create Public IP Resource
# Public IP Resource should be in the same location as the application gateway. Allocation method static.

resource "azurerm_public_ip" "ip" {
  name                = "${var.appgw_name}-pip"
  resource_group_name = var.appgw_rsg
  location            = var.appgw_location
  allocation_method   = "Static"
  sku                 = "Standard"
  availability_zone   = var.availability_zone_for_pip
}

#
# Aplication Gateway Instance Details
#

resource "azurerm_application_gateway" "appgw" {
  name                = var.appgw_name
  resource_group_name = var.appgw_rsg
  location            = var.appgw_location
  enable_http2        = var.enable_http2
  zones               = var.availability_zones
  tags                = var.tags

  sku {
    name     = var.sku
    tier     = var.sku
    capacity = var.autoscaling_parameters != null ? null : var.sku_capacity
  }

  dynamic "autoscale_configuration" {
    for_each = toset(var.autoscaling_parameters != null ? ["fake"] : [])
    content {
      min_capacity = lookup(var.autoscaling_parameters, "min_capacity")
      max_capacity = lookup(var.autoscaling_parameters, "max_capacity", 5)
    }
  }

  gateway_ip_configuration {
    name      = local.gateway_ip_configuration_name
    subnet_id = data.azurerm_subnet.appgwsubnet.id
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.msi.id]
  }

  #
  # WAF settings
  #

  dynamic "waf_configuration" {
    for_each = var.waf_enabled ? ["fake"] : []
    content {
      enabled                  = var.waf_enabled
      file_upload_limit_mb     = coalesce(var.file_upload_limit_mb, 100)
      firewall_mode            = coalesce(var.waf_mode, "Detection")
      max_request_body_size_kb = coalesce(var.max_request_body_size_kb, 128)
      request_body_check       = coalesce(var.request_body_check, true)
      rule_set_type            = coalesce(var.rule_set_type, "OWASP")
      rule_set_version         = coalesce(var.rule_set_version, "3.0")
    }
  }

  #
  # Frontend - Public and Private (Private IP allocation method must be Static for v2 SKU.)
  # v2 SKU does not support only private IP addresses as the frontend. It has to be either public or both (public and private).

  frontend_ip_configuration {
    name                 = local.public_frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.ip.id
  }

  dynamic "frontend_ip_configuration" {
    for_each = var.appgw_private ? ["fake"] : []
    content {
      name                          = local.private_frontend_ip_configuration_name
      private_ip_address_allocation = var.appgw_private ? "Static" : null
      private_ip_address            = var.appgw_private ? var.appgw_private_ip : null
      subnet_id                     = var.appgw_private ? data.azurerm_subnet.appgwsubnet.id : null
    }
  }

  dynamic "frontend_port" {
    for_each = var.frontend_port_settings
    content {
      name = lookup(frontend_port.value, "name", null)
      port = lookup(frontend_port.value, "port", null)
    }
  }

  # 
  # Backend Pools
  #

  dynamic "backend_address_pool" {
    for_each = var.backendpools
    content {
      name         = lookup(backend_address_pool.value, "name")
      fqdns        = lookup(backend_address_pool.value, "fqdns", null)
      ip_addresses = lookup(backend_address_pool.value, "ip_addresses", null)
    }
  }

  # 
  # Probe
  #

  dynamic "probe" {
    for_each = var.appgw_probes
    content {
      host                                      = lookup(probe.value, "host", null)
      interval                                  = lookup(probe.value, "interval", 30)
      name                                      = lookup(probe.value, "name", null)
      path                                      = lookup(probe.value, "path", "/")
      protocol                                  = lookup(probe.value, "protocol", "https")
      timeout                                   = lookup(probe.value, "timeout", 30)
      pick_host_name_from_backend_http_settings = lookup(probe.value, "pick_host_name_from_backend_http_settings", false)
      unhealthy_threshold                       = lookup(probe.value, "unhealthy_threshold", 3)
      match {
        body        = lookup(probe.value, "match_body", "")
        status_code = lookup(probe.value, "match_status_code", ["200-399"])
      }
    }
  }

  # 
  # ssl certificate
  #

  dynamic "ssl_certificate" {
    for_each = var.ssl_certificates_configs
    content {
      name                = lookup(ssl_certificate.value, "name", null)
      data                = lookup(ssl_certificate.value, "data", null)
      password            = lookup(ssl_certificate.value, "password", null)
      key_vault_secret_id = lookup(ssl_certificate.value, "key_vault_secret_id", null)
    }
  }

  #
  # listener
  # (A listener is a logical entity that checks for incoming connection requests by using the port, protocol, host, and IP address.)

  dynamic "http_listener" {
    for_each = var.http_listeners
    content {
      name                           = lookup(http_listener.value, "name")
      frontend_ip_configuration_name = lookup(http_listener.value, "frontend_type") == "public" ? local.public_frontend_ip_configuration_name : local.private_frontend_ip_configuration_name
      frontend_port_name             = lookup(http_listener.value, "frontend_port_name") # same as frontend_port.name
      protocol                       = lookup(http_listener.value, "protocol", "https")
      ssl_certificate_name           = lookup(http_listener.value, "ssl_certificate_name", null)
      host_name                      = lookup(http_listener.value, "host_name", null)
      require_sni                    = lookup(http_listener.value, "require_sni", null)
      firewall_policy_id             = lookup(http_listener.value, "firewall_policy_id", null)
    }
  }

  #
  # Trusted root certificate
  #

  dynamic "trusted_root_certificate" {
    for_each = var.trusted_root_certificate_configs
    content {
      name = lookup(trusted_root_certificate.value, "name", null)
      data = lookup(trusted_root_certificate.value, "data", null) == null ? filebase64(lookup(trusted_root_certificate.value, "filename", null)) : lookup(trusted_root_certificate.value, "data", null)
    }
  }

  #
  # http Settings
  # 

  # (The application gateway routes traffic to the back-end servers by using the configuration that you specify here.)

  dynamic "backend_http_settings" {
    for_each = var.appgw_backend_http_settings
    content {
      name       = lookup(backend_http_settings.value, "name", null)
      path       = lookup(backend_http_settings.value, "path", "")
      probe_name = lookup(backend_http_settings.value, "probe_name", null)

      affinity_cookie_name                = lookup(backend_http_settings.value, "affinity_cookie_name", "ApplicationGatewayAffinity")
      cookie_based_affinity               = lookup(backend_http_settings.value, "cookie_based_affinity", "Disabled")
      pick_host_name_from_backend_address = lookup(backend_http_settings.value, "pick_host_name_from_backend_address", true)
      host_name                           = lookup(backend_http_settings.value, "host_name", null)
      port                                = lookup(backend_http_settings.value, "port")
      protocol                            = lookup(backend_http_settings.value, "protocol", "Https")
      request_timeout                     = lookup(backend_http_settings.value, "request_timeout", 20)
      trusted_root_certificate_names      = lookup(backend_http_settings.value, "trusted_root_certificate_names", [])
    }
  }

  # 
  # Routing Rule
  # (Bind listener with the back-end pool and back-end HTTP settings)

  dynamic "request_routing_rule" {
    for_each = var.routing_rules
    content {
      name                       = lookup(request_routing_rule.value, "name")
      rule_type                  = lookup(request_routing_rule.value, "rule_type", "Basic")
      http_listener_name         = lookup(request_routing_rule.value, "http_listener_name")
      backend_address_pool_name  = lookup(request_routing_rule.value, "backend_address_pool_name", null)
      backend_http_settings_name = lookup(request_routing_rule.value, "backend_http_settings_name", null)
      url_path_map_name          = lookup(request_routing_rule.value, "url_path_map_name", null)
    }
  }

  # 
  # url_path_map 
  # Path based rules. Route traffic from listener specified in the rule to different backend targets based on the URL path of the request.

  dynamic "url_path_map" {
    for_each = var.url_path_map
    content {
      name                               = lookup(url_path_map.value, "name", null)
      default_backend_address_pool_name  = lookup(url_path_map.value, "default_backend_address_pool_name", null)
      default_backend_http_settings_name = lookup(url_path_map.value, "default_backend_http_settings_name", null)

      dynamic "path_rule" {
        for_each = lookup(url_path_map.value, "path_rule")
        content {
          name                       = lookup(path_rule.value, "path_rule_name", null)
          backend_address_pool_name  = lookup(path_rule.value, "backend_address_pool_name", null)
          backend_http_settings_name = lookup(path_rule.value, "backend_http_settings_name", null)
          paths                      = flatten([lookup(path_rule.value, "paths", null)])
        }
      }
    }
  }
}

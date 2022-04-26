# Aplication Gateway Instance Details
resource "azurerm_application_gateway" "appgw" {
  name                = var.appgw_name
  resource_group_name = var.appgw_rsg
  location            = var.appgw_location
  enable_http2        = var.enable_http2
  tags                = var.tags

  sku {
    name     = var.appgw_sku_size
    tier     = var.appgw_tier
    capacity = var.appgw_capacity
  }

  gateway_ip_configuration {
    name      = "${var.appgw_name}-appgw-ipconfig"
    subnet_id = var.subnet_id
  }

  # WAF on Application Gateway settings
  waf_configuration {
    enabled                  = var.waf_enabled
    firewall_mode            = coalesce(var.waf_configuration != null ? var.waf_configuration.firewall_mode : null, "Detection")
    rule_set_type            = coalesce(var.waf_configuration != null ? var.waf_configuration.rule_set_type : null, "OWASP")
    rule_set_version         = coalesce(var.waf_configuration != null ? var.waf_configuration.rule_set_version : null, "3.0")
    file_upload_limit_mb     = coalesce(var.waf_configuration != null ? var.waf_configuration.file_upload_limit_mb : null, 100)
    max_request_body_size_kb = coalesce(var.waf_configuration != null ? var.waf_configuration.max_request_body_size_kb : null, 128)
  }

  # Frontend
  frontend_ip_configuration {
    name                          = "${var.frontend_ip_configuration_name}-private"
    private_ip_address            = var.private_ip_address
    private_ip_address_allocation = "Static"
    subnet_id                     = var.subnet_id
  }

  frontend_port {
    name = "${var.appgw_name}-feport-${var.frontend_port_number}"
    port = var.frontend_port_number
  }

  # Backend Pools
  dynamic "backend_address_pool" {
    for_each = var.backendpools
    iterator = backendpool
    content {
      name         = backendpool.value.name
      fqdns        = backendpool.value.ip_addresses == null ? backendpool.value.fqdns : null
      ip_addresses = backendpool.value.fqdns == null ? backendpool.value.ip_addresses : null
    }
  }

  # probe
  dynamic "probe" {
    for_each = var.probe
    iterator = probe
    content {
      name                                      = probe.value.name
      protocol                                  = probe.value.protocol
      interval                                  = probe.value.interval
      timeout                                   = probe.value.timeout
      unhealthy_threshold                       = probe.value.unhealthy_threshold
      pick_host_name_from_backend_http_settings = probe.value.pick_host_name_from_backend_http_settings
      path                                      = probe.value.path
      host                                      = probe.value.pick_host_name_from_backend_http_settings == false ? probe.value.host : null
    }
  }

  # Listener (A listener is a logical entity that checks for incoming connection requests by using the port, protocol, host, and IP address.)

  ssl_certificate {
    name     = var.ssl_certificate.name
    data     = filebase64(var.ssl_certificate.data)
    password = var.ssl_certificate.password
  }

  http_listener {
    name                           = "${var.appgw_name}-httplistener-${var.http_listener_protocol}"
    frontend_ip_configuration_name = "${var.frontend_ip_configuration_name}-private"
    frontend_port_name             = "${var.appgw_name}-feport-${var.frontend_port_number}"
    protocol                       = var.http_listener_protocol
    ssl_certificate_name           = var.http_listener_protocol == "https" ? var.ssl_certificate.name : null
  }

  # http Settings (The application gateway routes traffic to the back-end servers by using the configuration that you specify here.)

  backend_http_settings {
    name                  = var.http_settings_name
    cookie_based_affinity = var.cookie_based_affinity
    port                  = var.backend_port
    protocol              = var.backend_protocol
    request_timeout       = var.request_timeout
    connection_draining {
      enabled           = var.connection_draining
      drain_timeout_sec = var.drain_timeout
    }
    pick_host_name_from_backend_address = var.hostfrombackend
    probe_name                          = var.custom_probe
  }

  # Routing Rule 

  # url_path_map - Path based rules. Route traffic from listener specified in the rule to different backend targets based on the URL path of the request.

  url_path_map {
    name                               = var.url_path_map_name
    default_backend_address_pool_name  = var.defaultpool
    default_backend_http_settings_name = var.http_settings_name
    dynamic "path_rule" {
      for_each = var.path_rule
      iterator = path_rule
      content {
        name                       = path_rule.value.name
        paths                      = path_rule.value.paths
        backend_address_pool_name  = path_rule.value.backend_address_pool_name
        backend_http_settings_name = path_rule.value.backend_http_settings_name
      }
    }
  }

  # Create routing rule (Bind listener with the back-end pool and back-end HTTP settings)

  request_routing_rule {
    name                       = var.routing_rule_name
    rule_type                  = var.routing_rule_type
    http_listener_name         = "${var.appgw_name}-httplistener-${var.http_listener_protocol}"
    backend_address_pool_name  = var.defaultpool
    backend_http_settings_name = var.http_settings_name
    url_path_map_name          = var.url_path_map_name
  }
}

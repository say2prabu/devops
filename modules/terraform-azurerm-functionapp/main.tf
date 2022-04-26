resource "azurerm_function_app" "main" {
  name                       = var.function_app_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  app_service_plan_id        = var.app_service_plan_id
  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_access_key
  tags                       = var.tags
  https_only                 = var.enable_https
  app_settings               = merge(local.default_app_settings, var.app_settings)

  dynamic "site_config" {
    for_each = [var.site_config]

    content {
      always_on                 = lookup(site_config.value, "always_on", false)
      ftps_state                = lookup(site_config.value, "ftps_state", "FtpsOnly")
      http2_enabled             = lookup(site_config.value, "http2_enabled", false)
      min_tls_version           = lookup(site_config.value, "min_tls_version", "1.2")
      use_32_bit_worker_process = lookup(site_config.value, "use_32_bit_worker_process", true)
      websockets_enabled        = lookup(site_config.value, "websockets_enabled", null)

      dynamic "cors" {
        for_each = lookup(site_config.value, "cors", [])
        content {
          allowed_origins     = cors.value.allowed_origins
          support_credentials = lookup(cors.value, "support_credentials", null)
        }
      }
    }
  }

  dynamic "connection_string" {
    for_each = var.connection_strings
    content {
      name  = lookup(connection_string.value, "name", null)
      type  = lookup(connection_string.value, "type", null)
      value = lookup(connection_string.value, "value", null)
    }
  }
}

resource "azurerm_app_service_virtual_network_swift_connection" "main" {
  app_service_id = resource.azurerm_function_app.main.id
  subnet_id      = var.subnet_id
}

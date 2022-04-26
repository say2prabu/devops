resource "azurerm_app_service" "main" {
  name                    = var.appservice_name
  location                = var.location
  resource_group_name     = var.resource_group_name
  app_service_plan_id     = var.app_service_plan_id
  tags                    = var.tags
  client_affinity_enabled = var.enable_client_affinity
  https_only              = var.enable_https
  client_cert_enabled     = var.enable_client_certificate

  dynamic "site_config" {
    for_each = [merge(local.default_site_config, var.site_config)]

    content {
      always_on                 = lookup(site_config.value, "always_on", false)
      #app_command_line          = lookup(site_config.value, "app_command_line", null)
      default_documents         = lookup(site_config.value, "default_documents", null)
      dotnet_framework_version  = lookup(site_config.value, "dotnet_framework_version", "v4.0")
      ftps_state                = lookup(site_config.value, "ftps_state", "FtpsOnly")
      #health_check_path         = lookup(site_config.value, "health_check_path", null)
      http2_enabled             = lookup(site_config.value, "http2_enabled", false)
      #java_container            = lookup(site_config.value, "java_container", null)
      #java_container_version    = lookup(site_config.value, "java_container_version", null)
      #java_version              = lookup(site_config.value, "java_version", null)
      #local_mysql_enabled       = lookup(site_config.value, "local_mysql_enabled", null)
      #linux_fx_version          = lookup(site_config.value, "linux_fx_version", null)
      #windows_fx_version        = lookup(site_config.value, "windows_fx_version", null)
      #managed_pipeline_mode     = lookup(site_config.value, "managed_pipeline_mode", "Integrated")
      min_tls_version           = lookup(site_config.value, "min_tls_version", "1.2")
      #php_version               = lookup(site_config.value, "php_version", null)
      #python_version            = lookup(site_config.value, "python_version", null)
      #remote_debugging_enabled  = lookup(site_config.value, "remote_debugging_enabled", null)
      #remote_debugging_version  = lookup(site_config.value, "remote_debugging_version", null)
      #scm_type                  = lookup(site_config.value, "scm_type", null)
      #use_32_bit_worker_process = lookup(site_config.value, "use_32_bit_worker_process", true)
      #websockets_enabled        = lookup(site_config.value, "websockets_enabled", null)


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
  app_service_id = resource.azurerm_app_service.main.id
  subnet_id      = var.subnet_id
}


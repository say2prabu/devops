variable "azure_region" {
  type = string
}
variable "organization_code" {
  type = string
}
variable "environment_code" {
  type = string
}
variable "subscription_code" {
  type = string
}
variable "backend_suffix" {
  type = list(string)
}
variable "shared_suffix" {
  type = list(string)
}
variable "afqp_suffix" {
  type = list(string)
}
variable "websi_suffix" {
  type = list(string)
}
variable "vnet_name" {
  type = string
}
variable "vnet_rsgname" {
  type = string
}
variable "data_subnet_name" {
  type = string
}
variable "msqli_subnet_name" {
  type = string
}
variable "app_subnet_name" {
  type = string
}
variable "appsvc_subnet_name" {
  type = string
}
variable "appgw_subnet_name" {
  description = "Subnet to deploy Application Gateway."
  type        = string
}
variable "rsg_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
}
variable "dns_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
}
variable "sa_account_kind" {
  type    = string
  default = "StorageV2"
}
variable "sa_account_tier" {
  type    = string
  default = "Standard"
}
variable "sa_account_replication_type" {
  type    = string
  default = "ZRS"
}
variable "sa_access_tier" {
  type    = string
  default = "Hot"
}
variable "sa_allow_blob_public_access" {
  type    = bool
  default = false
}
variable "sa_shared_access_key_enabled" {
  type    = bool
  default = true
}
variable "sa_blob_delete_retention_policy" {
  type = number
}
variable "sa_container_delete_retention_policy" {
  type = number
}
variable "sa_bypass" {
  type    = list(string)
  default = ["AzureServices", "Logging", "Metrics"]
}
variable "sa_default_action" {
  type    = string
  default = "Deny"
}
variable "sa_ip_rules" {
  type = list(any)
}
variable "afqp_sa_container_names" {
  type = set(string)
}
variable "sa_container_access_type" {
  type    = string
  default = "private"
}
variable "websi_sa_share_names" {
  type = set(string)
}
variable "websi_sa_table_names" {
  type = set(string)
}
variable "websi_sa_queue_names" {
  type = set(string)
}
variable "afqp_sa_table_names" {
  type = set(string)
}
variable "sa_share_quota" {
  type = number
}
variable "afqp_sa_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default = {
    "AtosManaged"      = "true"
    "AtosMonitoringID" = "value"
  }
}
variable "websi_sa_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default = {
    "AtosManaged"      = "true"
    "AtosMonitoringID" = "value"
  }
}
variable "sa_subresources_name" {
  type    = list(string)
  default = ["blob"]
}
variable "redis_subresources_name" {
  type    = list(string)
  default = ["redisCache"]
}
variable "redis_cache_family" {
  type        = string
  description = "Provide Redis Cache Family."
}
variable "redis_cache_skuname" {
  type        = string
  description = "Provide Redis Cache SKU name."
}
variable "redis_cache_capacity" {
  type        = number
  description = "Provide Redis Cache capacity name."
}
variable "afqp_redis_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default = {
    "AtosManaged"      = "true"
    "AtosMonitoringID" = "value"
  }
}
variable "websi_redis_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default = {
    "AtosManaged"      = "true"
    "AtosMonitoringID" = "value"
  }
}
variable "cosmosdb_dbname" {
  type        = string
  description = "Specifies the name of the Cosmos DB Mongo Database. Changing this forces a new resource to be created."
}
variable "cosmosdb_collection_name" {
  type        = string
  description = "Specifies the name of the Cosmos DB Mongo Collection. Changing this forces a new resource to be created."
}
variable "cosmosdb_offer_type" {
  type    = string
  default = "Standard"
}
variable "cosmosdb_interval_in_minutes" {
  type = number
}
variable "cosmosdb_retention_in_hours" {
  type = number
}
variable "cosmosdb_default_ttl_seconds" {
  type    = number
  default = 777
}
variable "cosmosdb_shard_key" {
  type    = string
  default = "UniqueKey"
}
variable "cosmosdb_tags" {
  type = map(string)
  default = {
    "AtosManaged"      = "true"
    "AtosMonitoringID" = "value"
  }
}
variable "cosmosdb_subresources_name" {
  type    = list(string)
  default = ["MongoDB"]
}
variable "msqli_administrator_login_password" {
  type        = string
  description = "The password associated with the administrator_login user."
  sensitive   = true
}
variable "msqli_sku_name" {
  type        = string
  description = "Specifies the SKU Name for the SQL Managed Instance. Valid values include GP_Gen4, GP_Gen5, BC_Gen4, BC_Gen5."
}
variable "msqli_collation" {
  type        = string
  description = "Specifies how the SQL Managed Instance will be collated. Default value is SQL_Latin1_General_CP1_CI_AS."
  default     = "SQL_Latin1_General_CP1_CI_AS"
}
variable "msqli_timezone_id" {
  type        = string
  description = "The TimeZone ID that the SQL Managed Instance will be operating in. Default value is UTC."
  default     = "W. Europe Standard Time"
}
variable "msqli_storage_size_in_gb" {
  type        = number
  description = "Maximum storage space for your instance. It should be a multiple of 32GB."
}
variable "msqli_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default = {
    "AtosManaged"      = "true"
    "AtosMonitoringID" = "value"
  }
}
variable "appservice_service_plan" {
  description = "Definition of the dedicated plan to use"
  type = object({
    kind             = string
    size             = string
    tier             = string
    per_site_scaling = bool
  })
}
variable "appsvc_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default = {
    "AtosManaged"      = "true"
    "AtosMonitoringID" = "value"
  }
}
variable "application_insights_type" {
  type        = string
  description = "specifies application insights type"
  default     = "web"
}
variable "application_insights_retention_in_days" {
  type        = number
  description = "specifies the number of days for logs retention"
  default     = 90
}
variable "application_insights_disable_ip_masking" {
  type        = bool
  description = "enable of disable ip masking"
  default     = true
}
variable "afqp_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default = {
    "AtosManaged"      = "true"
    "AtosMonitoringID" = "value"
  }
}
variable "websi_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default = {
    "AtosManaged"      = "true"
    "AtosMonitoringID" = "value"
  }
}
variable "afqp_webapp_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default = {
    "AtosManaged"      = "true"
    "AtosMonitoringID" = "value"
  }
}
variable "websi_webapp_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default = {
    "AtosManaged"      = "true"
    "AtosMonitoringID" = "value"
  }
}
variable "appservice_site_config" {
  type        = any
  description = "Site configuration for Application Service"
}
variable "enable_appservice_vnet_integration" {
  type        = bool
  description = "Does the app service require vnet integration or not"
  default     = false
}
variable "appsvc_subresources_name" {
  type    = list(string)
  default = ["sites"]
}
variable "appgw_enable_http2" {
  description = "HTTP2 enabled on the application gateway. Defaults to false."
  type        = bool
  default     = false
}
variable "appgw_sku_size" {
  description = "Application Gateway SKU size. Possible values: Standard_Small, Standard_Medium, Standard_Large, Standard_v2, WAF_Medium, WAF_Large, and WAF_v2."
  type        = string
  default     = "WAF_Medium"
}
variable "appgw_tier" {
  description = "Application Gateway SKU tier. Possible values are Standard, Standard_v2, WAF and WAF_v2."
  type        = string
  default     = "WAF"
}
variable "appgw_capacity" {
  description = "The Capacity of the SKU to use for this Application Gateway. When using a V1 SKU this value must be between 1 and 32."
  type        = number
  default     = 2
}
variable "appgw_waf_enabled" {
  description = "WAF on Application Gateway. Set to true to enable."
  type        = bool
  default     = true
}
variable "appgw_waf_configuration" {
  description = "Configuration block for WAF. Defaults to null, which configures WAF with these settings: Detection, OWASP, 3.0, 100, 128. For details please refer README.md. "
  type = object({
    firewall_mode            = string
    rule_set_type            = string
    rule_set_version         = string
    file_upload_limit_mb     = number
    max_request_body_size_kb = number
  })
  default = null
}
variable "appgw_frontend_ip_configuration_name" {
  description = "The name of the Frontend IP Configuration."
  type        = string
}
variable "appgw_private_ip_address" {
  description = "The Private IP Address to use for the Application Gateway. Pick one from the subnet this Application Gateway is deployed in. Static allocation."
  type        = string
}
variable "appgw_frontend_port_number" {
  description = "Enter a frontend port number for the listener. You can use well known ports, such as port 80 and 443, or any port ranging from 1 to 65502 (v1 SKU) or 1 to 65199 (v2 SKU)."
  type        = number
  default     = 443
}
variable "appgw_ssl_certificate" {
  description = "SSL certficate configuration. Please read README.md for detailed explanation."
  type = object({
    name     = string,
    data     = string,
    password = string
  })
}
variable "appgw_probe" {
  description = "Probe configuration. Please read README.md for detailed explanation."
  type = list(object({
    name                                      = string,
    protocol                                  = string,
    interval                                  = number,
    timeout                                   = number,
    unhealthy_threshold                       = number,
    pick_host_name_from_backend_http_settings = bool,
    host                                      = string,
    path                                      = string
  }))
  default = [
    {
      name                                      = "customprobe",
      protocol                                  = "https",
      interval                                  = 30,
      timeout                                   = 30,
      unhealthy_threshold                       = 3,
      pick_host_name_from_backend_http_settings = true,
      host                                      = null
      path                                      = "/"
    }
  ]
}
variable "appgw_backendpools" {
  description = "Backend Pools. Supply a name for the pool and a list of fqdn's/IP's which should be part of the backend address pool. Example: example..azurewebsites.net"
  type = list(object({
    name         = string,
    fqdns        = list(string),
    ip_addresses = list(string)
  }))
}
variable "appgw_http_listener_protocol" {
  description = "The Protocol to use for HTTP Listener. Possible values are Http and Https."
  type        = string
  default     = "https"
}
variable "appgw_http_settings_name" {
  description = "Http Settings: name - between 1 and 80 characters. Must begin with a letter or number, end with a letter, number or underscore, and may contain only letters, numbers, underscores, periods, or hyphens."
  type        = string
}
variable "appgw_cookie_based_affinity" {
  description = "Http Settings: Is Cookie-Based Affinity enabled? Possible values are Enabled and Disabled."
  type        = string
  default     = "Disabled"
}
variable "appgw_backend_port" {
  description = "Http Settings: The port which should be used for this Backend HTTP Settings Collection (80, 443)."
  type        = number
  default     = 443
}
variable "appgw_backend_protocol" {
  description = "Http Settings: The Protocol which should be used. Possible values are Http and Https."
  type        = string
  default     = "https"
}
variable "appgw_request_timeout" {
  description = "Http Settings: The request timeout is the number of seconds that the application gateway will wait to receive a response from the backend pool before it returns a “connection timed out” error message - - between 1 and 86400 seconds."
  type        = number
  default     = 20
}
variable "appgw_connection_draining" {
  description = "Http Settings: If connection draining is enabled or not. Defaults to false."
  type        = bool
  default     = false
}
variable "appgw_drain_timeout" {
  description = "Http Settings: The number of seconds connection draining is active. Acceptable values are from 1 second to 3600 seconds. Specify this value even if connection_draining is set to false."
  type        = number
  default     = 60
}
variable "appgw_hostfrombackend" {
  description = "Http Settings: Pick host name from backend target. Defaults to true."
  type        = bool
  default     = true
}
variable "appgw_custom_probe" {
  description = "Http Settings: The name of an associated custom Probe."
  type        = string
  default     = "customprobe"
}
variable "appgw_path_rule" {
  description = "Path based rules. Forms a part of URL path map."
  type = list(object({
    name                       = string,
    paths                      = list(string),
    backend_address_pool_name  = string,
    backend_http_settings_name = string
  }))
}
variable "appgw_routing_rule_name" {
  description = "The Name of this Request Routing Rule."
  type        = string
}
variable "appgw_routing_rule_type" {
  description = "The Type of Routing that should be used for this Rule. Possible values are Basic and PathBasedRouting."
  type        = string
  default     = "PathBasedRouting"
}
variable "appgw_defaultpool" {
  description = "Default pool name to be used in Request Routing Rule."
  type        = string
}
variable "appgw_url_path_map_name" {
  description = "The Name of the URL Path Map which should be associated with this Routing Rule."
  type        = string
}
variable "appgw_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default = {
    "AtosManaged"      = "true"
    "AtosMonitoringID" = "value"
  }
}
variable "dns_zone_names" {
  type = map(object({
    name     = string
  }))
  description = "The name(s) of the Private DNS Zone."
}
variable "client_id" {
  type    = string
  default = " "
}
variable "client_secret" {
  type    = string
  default = " "
}
variable "subscription_id" {
  type    = string
  default = " "
}
variable "tenant_id" {
  type    = string
  default = " "
}
variable "afqp_mssql_db_names" {
  type = set(string)
}
variable "afqp_mssql_server_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default = {
    "AtosManaged"      = "true"
    "AtosMonitoringID" = "mssqlserver-id"
  }
}
variable "afqp_mssql_db_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default = {
    "AtosManaged"      = "true"
    "AtosMonitoringID" = "mssqlserverdb-id"
  }
}

variable "afqp_mssqlserver_subresources_name" {
  type    = list(string)
  default = ["sqlServer"]
}

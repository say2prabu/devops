module "afqp_rsg_naming" {
  source = "../../modules/terraform-naming"

  azure_region      = var.azure_region
  organization-code = var.organization_code
  environment-code  = var.environment_code
  subscription-code = var.subscription_code
  suffix            = concat(var.backend_suffix, ["afqp"])
}
module "websi_rsg_naming" {
  source = "../../modules/terraform-naming"

  azure_region      = var.azure_region
  organization-code = var.organization_code
  environment-code  = var.environment_code
  subscription-code = var.subscription_code
  suffix            = concat(var.backend_suffix, ["websi"])
}
module "afqp_redis_naming" {
  source = "../../modules/terraform-naming"

  azure_region      = var.azure_region
  organization-code = var.organization_code
  environment-code  = var.environment_code
  subscription-code = var.subscription_code
  suffix            = var.afqp_suffix
}
module "websi_redis_naming" {
  source = "../../modules/terraform-naming"

  azure_region      = var.azure_region
  organization-code = var.organization_code
  environment-code  = var.environment_code
  subscription-code = var.subscription_code
  suffix            = var.websi_suffix
}
module "afqp_sa_naming" {
  source = "../../modules/terraform-naming"

  azure_region      = var.azure_region
  organization-code = var.organization_code
  environment-code  = var.environment_code
  subscription-code = var.subscription_code
  suffix            = var.afqp_suffix
}
module "afqp_mssql_naming" {
  source = "../../modules/terraform-naming"

  azure_region      = var.azure_region
  organization-code = var.organization_code
  environment-code  = var.environment_code
  subscription-code = var.subscription_code
  suffix            = var.afqp_suffix
}
module "websi_sa_naming" {
  source = "../../modules/terraform-naming"

  azure_region      = var.azure_region
  organization-code = var.organization_code
  environment-code  = var.environment_code
  subscription-code = var.subscription_code
  suffix            = var.websi_suffix
}
module "cosmosdb_naming" {
  source = "../../modules/terraform-naming"

  azure_region      = var.azure_region
  organization-code = var.organization_code
  environment-code  = var.environment_code
  subscription-code = var.subscription_code
  suffix            = var.websi_suffix
}
module "shared_naming" {
  source = "../../modules/terraform-naming"

  azure_region      = var.azure_region
  organization-code = var.organization_code
  environment-code  = var.environment_code
  subscription-code = var.subscription_code
  suffix            = var.shared_suffix
}
module "afqp_app_naming" {
  source = "../../modules/terraform-naming"

  azure_region      = var.azure_region
  organization-code = var.organization_code
  environment-code  = var.environment_code
  subscription-code = var.subscription_code
  suffix            = var.afqp_suffix
}
module "websi_app_naming" {
  source = "../../modules/terraform-naming"

  azure_region      = var.azure_region
  organization-code = var.organization_code
  environment-code  = var.environment_code
  subscription-code = var.subscription_code
  suffix            = var.websi_suffix
}
data "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.vnet_rsgname
}
data "azurerm_subnet" "data_subnet" {
  name                 = var.data_subnet_name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_virtual_network.vnet.resource_group_name
}
data "azurerm_subnet" "msqli_subnet" {
  name                 = var.msqli_subnet_name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_virtual_network.vnet.resource_group_name
}
data "azurerm_subnet" "appsvc_subnet" {
  name                 = var.appsvc_subnet_name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_virtual_network.vnet.resource_group_name
}
data "azurerm_subnet" "app_subnet" {
  name                 = var.app_subnet_name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_virtual_network.vnet.resource_group_name
}
data "azurerm_subnet" "appgw_subnet" {
  name                 = var.appgw_subnet_name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_virtual_network.vnet.resource_group_name
}
module "afqp_resourcegroup" {
  source = "../../modules/terraform-azurerm-resourcegroup"

  name     = module.afqp_rsg_naming.resource_group.name
  location = module.afqp_rsg_naming.azure_region
  tags     = var.rsg_tags
}
module "websi_resourcegroup" {
  source = "../../modules/terraform-azurerm-resourcegroup"

  name     = module.websi_rsg_naming.resource_group.name
  location = module.websi_rsg_naming.azure_region
  tags     = var.rsg_tags
}
module "shared_resourcegroup" {
  source = "../../modules/terraform-azurerm-resourcegroup"

  name     = module.shared_naming.resource_group.name
  location = module.shared_naming.azure_region
  tags     = var.rsg_tags
}
module "privatelink_dnszones" {
  source = "../../modules/terraform-azurerm-privatedns"

  dns_zone_name                   = var.dns_zone_names
  resource_group_name             = module.shared_resourcegroup.rsg_name
  tags                            = var.dns_tags
  virtual_network_id              = data.azurerm_virtual_network.vnet.id
}
module "afqp_storage_account" {
  source = "../../modules/terraform-azurerm-storageaccount"

  name                              = module.afqp_sa_naming.storage_account.name_unique
  resource_group_name               = module.afqp_resourcegroup.rsg_name
  location                          = module.afqp_resourcegroup.rsg_location
  account_kind                      = var.sa_account_kind
  account_tier                      = var.sa_account_tier
  account_replication_type          = var.sa_account_replication_type
  access_tier                       = var.sa_access_tier
  blob_delete_retention_policy      = var.sa_blob_delete_retention_policy
  container_delete_retention_policy = var.sa_container_delete_retention_policy
  container_name                    = var.afqp_sa_container_names
  table_name                        = var.afqp_sa_table_names
  default_action                    = var.sa_default_action
  ip_rules                          = var.sa_ip_rules
  bypass                            = var.sa_bypass
  tags                              = var.afqp_sa_tags
}
module "afqp_sa_privateendpoint" {
  source = "../../modules/terraform-azurerm-privateendpoint"

  name                        = module.afqp_sa_naming.private_endpoint.name_unique
  location                    = module.afqp_resourcegroup.rsg_location
  resource_group_name         = module.afqp_resourcegroup.rsg_name
  subnet_id                   = data.azurerm_subnet.data_subnet.id
  private_dns_zone_group_name = module.afqp_sa_naming.private_dns_zone_group_name.name_unique
  private_dns_zone_ids        = [module.privatelink_dnszones.private_dns["blob"].id]

  private_service_connection_name = module.afqp_sa_naming.private_service_connection.name_unique
  private_connection_resource_id  = module.afqp_storage_account.sa_id
  subresources_name               = var.sa_subresources_name
}
module "afqp_mssql_db" {
  source = "../../modules/terraform-azurerm-azuresqldatabase"

  name                = module.afqp_mssql_naming.mssql_server.name_unique
  resource_group_name = module.afqp_resourcegroup.rsg_name
  location            = module.afqp_resourcegroup.rsg_location
  tags                = var.afqp_mssql_server_tags

  database_name = var.afqp_mssql_db_names
  mssql_db_tags = var.afqp_mssql_db_tags
}
module "afqp_mssql_privateendpoint" {
  source = "../../modules/terraform-azurerm-privateendpoint"

  name                        = module.afqp_mssql_naming.private_endpoint.name_unique
  resource_group_name         = module.afqp_resourcegroup.rsg_name
  location                    = module.afqp_resourcegroup.rsg_location
  subnet_id                   = data.azurerm_subnet.data_subnet.id
  private_dns_zone_group_name = module.afqp_mssql_naming.private_dns_zone_group_name.name_unique
  private_dns_zone_ids        = [module.privatelink_dnszones.private_dns["database"].id]

  private_service_connection_name = module.afqp_mssql_naming.private_service_connection.name_unique
  private_connection_resource_id  = module.afqp_mssql_db.sqlserver_id
  subresources_name               = var.afqp_mssqlserver_subresources_name
}
module "afqp_redis_cache" {
  source = "../../modules/terraform-azurerm-rediscache"

  name                = module.afqp_redis_naming.redis_cache.name_unique
  resource_group_name = module.afqp_resourcegroup.rsg_name
  location            = module.afqp_resourcegroup.rsg_location
  capacity            = var.redis_cache_capacity
  family              = var.redis_cache_family
  sku_name            = var.redis_cache_skuname
  tags                = var.afqp_redis_tags
}
module "afqp_rediscache_privateendpoint" {
  source = "../../modules/terraform-azurerm-privateendpoint"

  name                        = module.afqp_redis_naming.private_endpoint.name_unique
  location                    = module.afqp_resourcegroup.rsg_location
  resource_group_name         = module.afqp_resourcegroup.rsg_name
  subnet_id                   = data.azurerm_subnet.data_subnet.id
  private_dns_zone_group_name = module.afqp_redis_naming.private_dns_zone_group_name.name_unique
  private_dns_zone_ids        = [module.privatelink_dnszones.private_dns["redis"].id]

  private_service_connection_name = module.afqp_redis_naming.private_service_connection.name_unique
  private_connection_resource_id  = module.afqp_redis_cache.redis_id
  subresources_name               = var.redis_subresources_name
}
module "websi_storage_account" {
  source = "../../modules/terraform-azurerm-storageaccount"

  name                              = module.websi_sa_naming.storage_account.name_unique
  resource_group_name               = module.websi_resourcegroup.rsg_name
  location                          = module.websi_resourcegroup.rsg_location
  account_kind                      = var.sa_account_kind
  account_tier                      = var.sa_account_tier
  account_replication_type          = var.sa_account_replication_type
  access_tier                       = var.sa_access_tier
  blob_delete_retention_policy      = var.sa_blob_delete_retention_policy
  container_delete_retention_policy = var.sa_container_delete_retention_policy
  share_name                        = var.websi_sa_share_names
  share_quota                       = var.sa_share_quota
  queue_name                        = var.websi_sa_queue_names
  table_name                        = var.websi_sa_table_names
  default_action                    = var.sa_default_action
  ip_rules                          = var.sa_ip_rules
  bypass                            = var.sa_bypass
  tags                              = var.websi_sa_tags
}
module "websi_sa_privateendpoint" {
  source = "../../modules/terraform-azurerm-privateendpoint"

  name                        = module.websi_sa_naming.private_endpoint.name_unique
  location                    = module.websi_resourcegroup.rsg_location
  resource_group_name         = module.websi_resourcegroup.rsg_name
  subnet_id                   = data.azurerm_subnet.data_subnet.id
  private_dns_zone_group_name = module.websi_sa_naming.private_dns_zone_group_name.name_unique
  private_dns_zone_ids        = [module.privatelink_dnszones.private_dns["blob"].id]

  private_service_connection_name = module.websi_sa_naming.private_service_connection.name_unique
  private_connection_resource_id  = module.websi_storage_account.sa_id
  subresources_name               = var.sa_subresources_name
}
module "websi_redis_cache" {
  source = "../../modules/terraform-azurerm-rediscache"

  name                = module.websi_redis_naming.redis_cache.name_unique
  resource_group_name = module.websi_resourcegroup.rsg_name
  location            = module.websi_resourcegroup.rsg_location
  capacity            = var.redis_cache_capacity
  family              = var.redis_cache_family
  sku_name            = var.redis_cache_skuname
  tags                = var.websi_redis_tags
}
module "websi_rediscache_privateendpoint" {
  source = "../../modules/terraform-azurerm-privateendpoint"

  name                        = module.websi_redis_naming.private_endpoint.name_unique
  location                    = module.websi_resourcegroup.rsg_location
  resource_group_name         = module.websi_resourcegroup.rsg_name
  subnet_id                   = data.azurerm_subnet.data_subnet.id
  private_dns_zone_group_name = module.websi_redis_naming.private_dns_zone_group_name.name_unique
  private_dns_zone_ids        = [module.privatelink_dnszones.private_dns["redis"].id]

  private_service_connection_name = module.websi_redis_naming.private_service_connection.name_unique
  private_connection_resource_id  = module.websi_redis_cache.redis_id
  subresources_name               = var.redis_subresources_name
}
module "cosmosdb" {
  source = "../../modules/terraform-azurerm-cosmosdb"

  name                = module.cosmosdb_naming.cosmosdb_account.name_unique
  resource_group_name = module.websi_resourcegroup.rsg_name
  location            = module.websi_resourcegroup.rsg_location
  dbname              = var.cosmosdb_dbname
  collection_name     = var.cosmosdb_collection_name
  offer_type          = var.cosmosdb_offer_type
  interval_in_minutes = var.cosmosdb_interval_in_minutes
  retention_in_hours  = var.cosmosdb_retention_in_hours
  default_ttl_seconds = var.cosmosdb_default_ttl_seconds
  shard_key           = var.cosmosdb_shard_key
  tags                = var.cosmosdb_tags
}
module "cosmosdb_privateendpoint" {
  source = "../../modules/terraform-azurerm-privateendpoint"

  name                        = module.cosmosdb_naming.private_endpoint.name_unique
  location                    = module.websi_resourcegroup.rsg_location
  resource_group_name         = module.websi_resourcegroup.rsg_name
  subnet_id                   = data.azurerm_subnet.data_subnet.id
  private_dns_zone_group_name = module.cosmosdb_naming.private_dns_zone_group_name.name_unique
  private_dns_zone_ids        = [module.privatelink_dnszones.private_dns["mongo"].id]

  private_service_connection_name = module.cosmosdb_naming.private_service_connection.name_unique
  private_connection_resource_id  = module.cosmosdb.cosmosdb_id
  subresources_name               = var.cosmosdb_subresources_name
}
module "appservice_plan" {
  source              = "../../modules/terraform-azurerm-appserviceplan"
  appsvcplan_name     = module.shared_naming.app_service_plan.name
  resource_group_name = module.shared_resourcegroup.rsg_name
  location            = module.shared_resourcegroup.rsg_location
  service_plan        = var.appservice_service_plan
  tags                = var.appsvc_tags
}
module "afqp_app_insights" {
  source                    = "../../modules/terraform-azurerm-applicationinsight"
  appinsights_name          = module.afqp_app_naming.application_insights.name
  resource_group_name       = module.shared_resourcegroup.rsg_name
  location                  = module.shared_resourcegroup.rsg_location
  application_insights_type = var.application_insights_type
  retention_in_days         = var.application_insights_retention_in_days
  disable_ip_masking        = var.application_insights_disable_ip_masking
  tags                      = var.afqp_tags
}
module "afqp_app_service" {
  source              = "../../modules/terraform-azurerm-appservice"
  appservice_name     = module.afqp_app_naming.app_service.name
  resource_group_name = module.shared_resourcegroup.rsg_name
  location            = module.shared_resourcegroup.rsg_location
  app_service_plan_id = module.appservice_plan.id

  site_config = var.appservice_site_config
  #enable_appservice_vnet_integration = true
  subnet_id = data.azurerm_subnet.appsvc_subnet.id
  tags      = var.afqp_webapp_tags
}
module "afqp_app_service_privateendpoint" {
  source = "../../modules/terraform-azurerm-privateendpoint"

  name                        = module.afqp_app_naming.private_endpoint.name_unique
  location                    = module.shared_resourcegroup.rsg_location
  resource_group_name         = module.shared_resourcegroup.rsg_name
  subnet_id                   = data.azurerm_subnet.app_subnet.id
  private_dns_zone_group_name = module.afqp_app_naming.private_dns_zone_group_name.name
  private_dns_zone_ids        = [module.privatelink_dnszones.private_dns["websites"].id]

  private_service_connection_name = module.afqp_app_naming.private_service_connection.name_unique
  private_connection_resource_id  = module.afqp_app_service.id
  subresources_name               = var.appsvc_subresources_name
}
module "websi_app_insights" {
  source                    = "../../modules/terraform-azurerm-applicationinsight"
  appinsights_name          = module.websi_app_naming.application_insights.name
  resource_group_name       = module.shared_resourcegroup.rsg_name
  location                  = module.shared_resourcegroup.rsg_location
  application_insights_type = var.application_insights_type
  retention_in_days         = var.application_insights_retention_in_days
  disable_ip_masking        = var.application_insights_disable_ip_masking
  tags                      = var.websi_tags
}
module "websi_app_service" {
  source              = "../../modules/terraform-azurerm-appservice"
  appservice_name     = module.websi_app_naming.app_service.name
  resource_group_name = module.shared_resourcegroup.rsg_name
  location            = module.shared_resourcegroup.rsg_location
  app_service_plan_id = module.appservice_plan.id

  site_config = var.appservice_site_config
  #enable_appservice_vnet_integration = true
  subnet_id = data.azurerm_subnet.appsvc_subnet.id
  tags      = var.websi_webapp_tags
}
module "websi_app_service_privateendpoint" {
  source = "../../modules/terraform-azurerm-privateendpoint"

  name                        = module.websi_app_naming.private_endpoint.name_unique
  location                    = module.shared_resourcegroup.rsg_location
  resource_group_name         = module.shared_resourcegroup.rsg_name
  subnet_id                   = data.azurerm_subnet.app_subnet.id
  private_dns_zone_group_name = module.websi_app_naming.private_dns_zone_group_name.name
  private_dns_zone_ids        = [module.privatelink_dnszones.private_dns["websites"].id]

  private_service_connection_name = module.websi_app_naming.private_service_connection.name_unique
  private_connection_resource_id  = module.websi_app_service.id
  subresources_name               = var.appsvc_subresources_name
}

module "msqli" {
  source = "../../modules/terraform-azurerm-managedsqlinstance"

  count = 0

  name                         = module.shared_naming.managed_sql_instance.name_unique
  resource_group_name          = module.shared_resourcegroup.rsg_name
  location                     = module.shared_resourcegroup.rsg_location
  administrator_login_password = var.msqli_administrator_login_password
  subnet_id                    = data.azurerm_subnet.msqli_subnet.id
  sku_name                     = var.msqli_sku_name
  collation                    = var.msqli_collation
  timezone_id                  = var.msqli_timezone_id
  storage_size_in_gb           = var.msqli_storage_size_in_gb
  tags                         = var.msqli_tags
}
module "appgw" {
  source = "../../modules/terraform-azurerm-applicationgateway"

  count = 0

  appgw_name                     = module.shared_naming.application_gateway.name
  appgw_rsg                      = module.shared_resourcegroup.rsg_name
  appgw_location                 = module.shared_resourcegroup.rsg_location
  enable_http2                   = var.appgw_enable_http2
  tags                           = var.appgw_tags
  appgw_sku_size                 = var.appgw_sku_size
  appgw_tier                     = var.appgw_tier
  appgw_capacity                 = var.appgw_capacity
  waf_enabled                    = var.appgw_waf_enabled
  waf_configuration              = var.appgw_waf_configuration
  subnet_id                      = data.azurerm_subnet.appgw_subnet.id
  frontend_ip_configuration_name = var.appgw_frontend_ip_configuration_name
  private_ip_address             = var.appgw_private_ip_address
  frontend_port_number           = var.appgw_frontend_port_number
  ssl_certificate                = var.appgw_ssl_certificate
  probe                          = var.appgw_probe
  backendpools                   = var.appgw_backendpools
  http_listener_protocol         = var.appgw_http_listener_protocol
  http_settings_name             = var.appgw_http_settings_name
  cookie_based_affinity          = var.appgw_cookie_based_affinity
  backend_port                   = var.appgw_backend_port
  backend_protocol               = var.appgw_backend_protocol
  request_timeout                = var.appgw_request_timeout
  connection_draining            = var.appgw_connection_draining
  drain_timeout                  = var.appgw_drain_timeout
  hostfrombackend                = var.appgw_hostfrombackend
  custom_probe                   = var.appgw_custom_probe
  url_path_map_name              = var.appgw_url_path_map_name
  path_rule                      = var.appgw_path_rule
  routing_rule_name              = var.appgw_routing_rule_name
  routing_rule_type              = var.appgw_routing_rule_type
  defaultpool                    = var.appgw_defaultpool
}

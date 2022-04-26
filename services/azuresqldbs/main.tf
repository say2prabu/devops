module "rsg_naming" {
  source = "../../modules/terraform-naming"

  azure_region      = var.azure_region
  organization-code = var.organization_code
  environment-code  = var.environment_code
  subscription-code = var.subscription_code
  suffix            = var.backend_suffix
}
module "mssql_naming" {
  source = "../../modules/terraform-naming"

  azure_region      = var.azure_region
  organization-code = var.organization_code
  environment-code  = var.environment_code
  subscription-code = var.subscription_code
  suffix            = var.backend_suffix
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
module "resourcegroup" {
  source = "../../modules/terraform-azurerm-resourcegroup"

  name     = module.rsg_naming.resource_group.name
  location = module.rsg_naming.azure_region
  tags     = var.rsg_tags
}
module "database_privatelink_dnszones" {
  source = "../../modules/terraform-azurerm-privatedns"

  dns_zone_name                   = var.dns_zone_names
  resource_group_name             = module.resourcegroup.rsg_name
  tags                            = var.dns_tags
  virtual_network_id              = data.azurerm_virtual_network.vnet.id
}
module "mssql_db" {
  source = "../../modules/terraform-azurerm-azuresqldatabase"

  name                = module.mssql_naming.mssql_server.name_unique
  resource_group_name = module.resourcegroup.rsg_name
  location            = module.resourcegroup.rsg_location
  tags                = var.mssql_server_tags

  database_name = var.mssql_db_names
  mssql_db_tags = var.mssql_db_tags
}
module "mssql_privateendpoint" {
  source = "../../modules/terraform-azurerm-privateendpoint"

  name                        = module.mssql_naming.private_endpoint.name_unique
  resource_group_name         = module.resourcegroup.rsg_name
  location                    = module.resourcegroup.rsg_location
  subnet_id                   = data.azurerm_subnet.data_subnet.id
  private_dns_zone_group_name = module.mssql_naming.private_dns_zone_group_name.name_unique
  private_dns_zone_ids        = [module.database_privatelink_dnszones.private_dns["database"].id] //should be resource id of privatelink.database.windows.net

  private_service_connection_name = module.mssql_naming.private_service_connection.name_unique
  private_connection_resource_id  = module.mssql_db.sqlserver_id
  subresources_name               = var.mssqlserver_subresources_name
}
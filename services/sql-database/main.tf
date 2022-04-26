# sql-database
module "naming" {
  source = "../../modules/terraform-naming"

  azure_region      = var.azure_region
  organization-code = var.organization-code
  environment-code  = var.environment-code
  subscription-code = var.subscription-code
}

module "mssql_db" {
  source = "../../modules/terraform-azurerm-azuresqldatabase"
  #depends_on = [module.sql-database]
  name                = module.naming.mssql_server.name # sql server name
  resource_group_name = var.resource_group_name
  location            = var.location
  mssql_db_tags       = var.mssql_db_tags

  name_mssql = var.name_mssql
  #   server_id            = var.server_id
  #   collation            = var.collation
  #   license_type         = var.license_type
  #   max_size_gb          = var.max_size_gb
  #   sku_name             = var.sku_name
  tags                     = var.tags
  zone_redundant       = var.zone_redundant
  storage_account_type = var.storage_account_type
}

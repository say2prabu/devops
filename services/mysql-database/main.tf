# module for my sql database
module "naming" {
  source = "../../modules/terraform-naming"

  azure_region      = var.azure_region
  organization-code = var.organization-code
  environment-code  = var.environment-code
  subscription-code = var.subscription-code
}
 module "azurerdbforysql" {
    source = "../../modules/terraform-azurerm-azuredbformysql"
   name                             = module.naming.mysql_server.name 
   resource_group_name              = var.mysql_server_resource_group_name
   location                         = var.mysql_server_location
   mysql_version                    = var.mysql_server_version
   sku_name                         = var.mysql_server_sku_name
   geo_redundant_backup_enabled     = var.geo_redundant_backup_enabled
    mysql_tags                       = var.mysql_tags 

   database_name                = var.database_name
   charset                      = var.charset
 }

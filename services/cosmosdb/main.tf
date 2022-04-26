module "naming_cosmosdb" {
  source = "../../modules/terraform-naming"
  azure_region      = var.azure_region
  organization-code = var.organization_code
  environment-code  = var.environment_code
  subscription-code = var.subscription_code
}

module "cosmosdb" {
  source = "../../modules/terraform-azurerm-cosmosdb"

  name                = module.naming_cosmosdb.cosmosdb_account.name_unique
  resource_group_name = var.resource_group_name  
#  resource_group_name = module.naming_cosmosdb.resource_group.name_unique
  location            = var.location
  dbname              = var.dbname
  collection_name     = var.collection_name
#  offer_type          = var.offer_type
  offer_type          = "Standard"
  kind                = "MongoDB"
  interval_in_minutes = var.interval_in_minutes
  retention_in_hours  = var.retention_in_hours
  default_ttl_seconds = var.default_ttl_seconds
  shard_key           = var.shard_key
  #throughput          = var.throughput
  tags                = var.cosmosdb_tags
}

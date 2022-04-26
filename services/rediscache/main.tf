provider "azurerm" {
  features {}
}

module "naming" {
  source = "../../modules/terraform-naming"

  azure_region      = var.azure_region
  organization-code = var.organization_code
  environment-code  = var.environment_code
  subscription-code = var.subscription_code
  suffix            = var.backend_suffix
}

module "resourcegroup" {
  source = "../../modules/terraform-azurerm-resourcegroup"

  name     = module.naming.resource_group.name
  location = module.naming.azure_region
  tags     = var.rsg_tags
}

module "redis_cache" {
  source = "../../modules/terraform-azurerm-rediscache"

  name                = module.naming.redis_cache.name_unique
  resource_group_name = module.resourcegroup.resource_group_name
  location            = module.resourcegroup.resource_group_location
  capacity            = var.capacity
  sku_name            = var.sku_name

  tags = {
    "AtosManaged" = "true"
    "Environment" = "Non-prod"
  }
}
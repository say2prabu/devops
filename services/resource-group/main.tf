module "naming" {
  source = "../../modules/terraform-naming"

  azure_region      = var.azure_region
  organization-code = var.organization-code
  environment-code = var.environment-code
  subscription-code = var.subscription-code
  suffix            = var.suffix
}

module "resource_group" {
    source = "../../modules/terraform-azurerm-resourcegroup"

    rsg_name     = module.naming.resource_group.name
    rsg_location = var.rsg_location
    tags     = var.tags
}
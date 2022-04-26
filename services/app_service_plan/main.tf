module "naming" {
  source = "../../modules/terraform-naming"

  azure_region      = var.azure_region
  organization-code = var.organization-code
  environment-code  = var.environment-code
  subscription-code = var.subscription-code
  suffix            = ["${var.service_plan_name}"]
}

module "resourcegroup" {
  source = "../../modules/terraform-azurerm-resourcegroup"

  name     = module.naming.resource_group.name
  location = module.naming.azure_region
  tags     = var.tags
}
module "app_service_plan" {
  source = "../../modules/terraform-azurerm-appserviceplan"
  appsvcplan_name         = module.naming.app_service_plan.name
  location                = module.resourcegroup.resource_group_location
  resource_group_name     = module.resourcegroup.resource_group_name
  service_plan = var.service_plan_definition
  tags = var.tags
}

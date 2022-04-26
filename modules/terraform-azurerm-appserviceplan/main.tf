resource "azurerm_app_service_plan" "main" {
  name                = var.appsvcplan_name
  resource_group_name = var.resource_group_name
  location            = var.location
  kind                = var.service_plan.kind
  reserved            = var.service_plan.kind == "Linux" ? true : false
  is_xenon            = var.service_plan.kind == "xenon" ? true : false
  per_site_scaling    = var.service_plan.per_site_scaling
  tags                = var.tags

  sku {
    tier = var.service_plan.tier
    size = var.service_plan.size
    #capacity = var.service_plan.capacity
  }
}

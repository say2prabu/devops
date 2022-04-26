module "loadbalancer_naming" {
  source = "../../modules/terraform-naming"

  azure_region      = var.azure_region
  organization-code = var.organization_code
  environment-code  = var.environment_code
  subscription-code = var.subscription_code
  #suffix            = var.backend_suffix
}
# module "loadbalancer_resourcegroup" {
#   source = "../../modules/terraform-azurerm-resourcegroup"

#   name     = module.loadbalancer_naming.resource_group.name
#   location = module.loadbalancer_naming.azure_region
#   tags     = var.rsg_tags
# }

module "loadbalancer" {
  source = "../../modules/terraform-azurerm-loadbalancer-public"

  name                 = module.loadbalancer_naming.loadbalancer.name
  location             = var.location
  resource_group_name  = var.resource_group_name
  sku                  = var.sku
#  sku_tier             = var.sku_tier
  tags                 = var.tags
  lb_pip               = var.lb_pip
  backend_pool         = var.backend_pool
  backend_pool_address = var.backend_pool_address
  lb_probe             = var.lb_probe
  lb_rule              = var.lb_rule
  lb_nat_rule          = var.lb_nat_rule
  lb_outbound_rule     = var.lb_outbound_rule
}
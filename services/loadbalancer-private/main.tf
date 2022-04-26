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

module "loadbalancer-private" {
  source = "../../modules/terraform-azurerm-loadbalancer-private"

  name                 = module.loadbalancer_naming.loadbalancer.name
  location             = var.location
  resource_group_name  = var.resource_group_name
  sku                  = var.sku
  tags                 = var.tags
  lb_private_ip        = var.lb_private_ip
  backend_pool         = var.backend_pool
  backend_pool_address = var.backend_pool_address
  lb_probe             = var.lb_probe
  lb_rule              = var.lb_rule
  lb_nat_rule          = var.lb_nat_rule
}

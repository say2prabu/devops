module "keyvault_naming" {
  source = "../../modules/terraform-naming"

  azure_region      = var.azure_region
  organization-code = var.organization_code
  environment-code  = var.environment_code
  subscription-code = var.subscription_code
  suffix            = var.backend_suffix
}
module "keyvault_resourcegroup" {
  source = "../../modules/terraform-azurerm-resourcegroup"

  name     = module.keyvault_naming.resource_group.name
  location = module.keyvault_naming.azure_region
  tags     = var.rsg_tags
}
module "keyvault" {
  source = "../../modules/terraform-azurerm-keyvault"

  name                    = module.keyvault_naming.keyvault.name
  location                = module.keyvault_resourcegroup.resource_group_location
  resource_group_name     = module.keyvault_resourcegroup.resource_group_name
  disk_encryption_enabled = var.disk_encryption_enabled
  sku                     = var.sku
  soft_delete_in_days     = var.soft_delete_in_days
  network_acls            = var.network_acls
  tags                    = var.tags
  access_policies         = var.access_policies
  secrets                 = var.secrets
  keys                    = var.keys
  certificates            = var.certificates
}

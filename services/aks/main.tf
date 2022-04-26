provider "azurerm" {
  features {}
}

# Networking
resource "azurerm_virtual_network" "vnet" {
  name                = "${module.naming_aks.resource_group.name}-vnet"
  location            = var.azure_region
  resource_group_name = var.resource_group_name
  address_space       = ["10.1.0.0/16"]
  tags                = var.aks_tags
}

resource "azurerm_subnet" "internal" {
  name                 = "${module.naming_aks.resource_group.name}-subnet"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = var.resource_group_name
  address_prefixes     = ["10.1.0.0/22"]
  depends_on = [
    azurerm_virtual_network.vnet
  ]
}

# Azure Kubernetes Service
module "naming_aks" {
  source = "../../modules/terraform-naming"
  azure_region      = var.azure_region
  organization-code = var.organization_code
  environment-code  = var.environment_code
  subscription-code = var.subscription_code
}

# module "resourcegroup_aks" {
#   source = "../../modules/terraform-azurerm-resourcegroup"
#   name     = module.naming_aks.resource_group.name
#   location = module.naming_aks.azure_region
#   tags     = var.rsg_tags
# }

module "aks" {
  source = "../../modules/terraform-azurerm-kubernetesservice"
  name                   = module.naming_aks.kubernetes_service.name_unique
  resource_group_name    = var.resource_group_name
  node_resource_group    = "${var.resource_group_name}-nodes"
  location               = var.azure_region
  vnet_subnet_id         = azurerm_subnet.internal.id
  dns_prefix             = var.dns_prefix
  tenant_id              = var.tenant_id
  admin_group_object_ids = var.admin_group_object_ids
  tags                   = var.aks_tags
}

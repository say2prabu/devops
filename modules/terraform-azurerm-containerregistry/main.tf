/*
* ## terraform-azurerm-containerregistry
* Terraform module to create Azure Container Registry
* 
* ## Description
* Azure Container Registry is a managed, private Docker registry service based on the open-source Docker Registry 2.0. Create and maintain Azure container registries to store and manage your private Docker container images and related artifacts.
* 
* ## Module example use
* ```hcl
* module "container_registry" {
*   source              = "../../modules/terraform-azurerm-containerregistry"
*   name                = "demoacr"
*   resource_group_name = "demo-rsg"
*   location            = "westeurope"
*   sku                 = "Basic"
*   tags = {
*     "AtosManaged" = "true"
*   }
* }
* ```
*
* ## License
* Atos, all rights protected - 2021.
*/

resource "azurerm_container_registry" "acr" {
  name                          = var.name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  sku                           = var.sku
  admin_enabled                 = var.admin_enabled
  public_network_access_enabled = var.public_network_access_enabled
  tags                          = var.tags

  identity {
    type = "SystemAssigned"
  }

  dynamic "georeplications" {
    for_each = var.georeplication_locations

    content {
      location = georeplications.value
      tags     = var.tags
    }
  }
}
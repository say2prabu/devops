resource "azurerm_resource_group" "rsg" {
  name     = var.name
  location = var.location
  tags     = var.tags
}
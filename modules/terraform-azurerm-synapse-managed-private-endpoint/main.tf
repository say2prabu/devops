resource "azurerm_synapse_managed_private_endpoint" "managed_private_endpoint" {
  name                 = var.name
  synapse_workspace_id = var.synapse_workspace_id
  target_resource_id   = var.target_resource_id
  subresource_name     = var.subresource_name
}
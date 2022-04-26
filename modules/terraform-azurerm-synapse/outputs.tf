output "workspace_endpoints" {
    value = azurerm_synapse_workspace.synapse_workspace.connectivity_endpoints
}
output "workspace_id" {
    value = azurerm_synapse_workspace.synapse_workspace.id
}
output "privatelink_hub_id" {
    value = azurerm_synapse_private_link_hub.synapse_private_link_hub.id
}
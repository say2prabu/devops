output "resource_group_name" {
  description = "Name of the created resourcegroup"
  value       = azurerm_resource_group.rsg.name
}

output "resource_group_location" {
  description = "Location of the created resourcegroup"
  value       = azurerm_resource_group.rsg.location
}

output "resource_group_id" {
  description = "Resource ID of the created resourcegroup"
  value       = azurerm_resource_group.rsg.id
}

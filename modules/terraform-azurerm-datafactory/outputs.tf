output "name" {
  value       = azurerm_data_factory.main.name
  description = "Name of the created data factory"
}

output "location" {
  value       = azurerm_data_factory.main.location
  description = "Location of the created data factory"
}

output "id" {
  value       = azurerm_data_factory.main.id
  description = "Generated data factory id"
}

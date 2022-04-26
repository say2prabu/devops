output "name" {
  value       = azurerm_databricks_workspace.main.name
  description = "Name of the created data factory"
}

output "location" {
  value       = azurerm_databricks_workspace.main.location
  description = "Location of the created data factory"
}

output "id" {
  value       = azurerm_databricks_workspace.main.id
  description = "Generated data factory id"
}

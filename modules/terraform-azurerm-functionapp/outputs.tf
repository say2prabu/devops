output "function_app_name" {
  description = "Name of the created Function app"
  value       = azurerm_function_app.main.name
}

output "rsg_location" {
  description = "Location of the created function app"
  value       = azurerm_function_app.main.location
}
output "id" {
  value       = azurerm_function_app.main.id
  description = "Generated Function app id"
}

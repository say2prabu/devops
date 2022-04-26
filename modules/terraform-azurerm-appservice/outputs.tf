output "app_service_name" {
  description = "Name of the created app service"
  value       = azurerm_app_service.main.name
}

output "rsg_location" {
  description = "Location of the created app service"
  value       = azurerm_app_service.main.location
}
output "id" {
  value       = azurerm_app_service.main.id
  description = "Generated app service id"
}
/*
output "publish_profile" {
  
}
*/
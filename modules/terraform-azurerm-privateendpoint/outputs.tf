output "private_endpoint_id" {
    description = "The resource id of the created private endpoint"
    value = azurerm_private_endpoint.private_endpoint.id
}

output "private_endpoint_name" {
    description = "The name of the created private endpoint"
    value = azurerm_private_endpoint.private_endpoint.name
}
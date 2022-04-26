output "appgw_v2_id" {
  description = "Id of the application gateway."
  value       = azurerm_application_gateway.appgw.id
}

output "appgw_v2_name" {
  description = "Name of the application gateway."
  value       = azurerm_application_gateway.appgw.name
}

output "appgw_v2_identity_principal_id" {
  description = "Principal id of the user assigned identity."
  value       = azurerm_user_assigned_identity.msi.principal_id
}

output "appgw_v2_identity_Resource_id" {
  description = "Resource id of the user assigned identity."
  value       = azurerm_user_assigned_identity.msi.id
}

output "appgw_v2_identity_Client_id" {
  description = "Resource id of the user assigned identity."
  value       = azurerm_user_assigned_identity.msi.client_id
}

output "appgw_v2_public_ip_address" {
  description = "The public IP address of Application Gateway."
  value       = azurerm_public_ip.ip.ip_address
}
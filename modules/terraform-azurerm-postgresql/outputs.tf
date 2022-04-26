output "administrator_login" {
  description = "Local admin user name"
  value       = var.administrator_login
}

output "administrator_login_password" {
  description = "Local admin user password"
  value       = local.administrator_login_password
  sensitive   = true
}

output "server_id" {
  value = var.deployment_mode_flexible ? azurerm_postgresql_flexible_server.postgresql_server[0].id : azurerm_postgresql_server.postgresql_server[0].id
}
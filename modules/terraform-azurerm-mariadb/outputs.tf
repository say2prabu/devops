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
  description = "ID of the server instance"
  value = azurerm_mariadb_server.mariadb_server.id
}
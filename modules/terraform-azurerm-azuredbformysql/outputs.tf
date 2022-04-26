output "server_id" {
    value = azurerm_mysql_server.mysqlserver.id
}
output "mysql_id" {
    value = azurerm_mysql_database.mysqldb.id
}
resource "azurerm_mysql_server" "mysqlserver" {
  name                             = var.name
  resource_group_name              = var.resource_group_name
  location                         = var.location
  version                          = var.mysql_version
  sku_name                         = var.sku_name
  storage_mb                       = var.db_storage
  administrator_login              = var.administrator_login
  administrator_login_password     = var.administrator_login_password
  public_network_access_enabled    = var.public_network_access_enabled
  ssl_enforcement_enabled          = var.ssl_enforcement_enabled
  ssl_minimal_tls_version_enforced = var.ssl_minimal_tls_version_enforced
  backup_retention_days            = var.backup_retention_days
  geo_redundant_backup_enabled     = var.geo_redundant_backup_enabled
  tags                             = var.mysql_tags
}

resource "azurerm_mysql_database" "mysqldb" {
  name                = var.database_name
  resource_group_name = azurerm_mysql_server.mysqlserver.resource_group_name
  server_name         = azurerm_mysql_server.mysqlserver.name
  charset             = var.charset
  collation           = var.collation
}

resource "azurerm_mysql_firewall_rule" "mysqlfw" {
  for_each            = var.ipv4_firewall_rule
  resource_group_name = azurerm_mysql_server.mysqlserver.resource_group_name
  server_name         = azurerm_mysql_server.mysqlserver.name
  name                = each.value.name
  start_ip_address    = each.value.range_start
  end_ip_address      = each.value.range_end
}
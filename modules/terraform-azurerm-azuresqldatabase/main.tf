resource "azurerm_mssql_server" "mssql_server" {
  name                          = var.name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  version                       = var.mssql_version
  administrator_login           = var.administrator_login
  administrator_login_password  = var.administrator_login_password
  minimum_tls_version           = var.minimum_tls_version
  connection_policy             = var.connection_policy
  public_network_access_enabled = var.public_network_access_enabled
  tags                          = var.tags
}

resource "azurerm_mssql_database" "mssql_database" {

  # for_each             = var.database_name
  name                 = var.name_mssql
  server_id            = azurerm_mssql_server.mssql_server.id
  collation            = var.collation
  license_type         = var.license_type
  max_size_gb          = var.max_size_gb
  sku_name             = var.sku_name
  zone_redundant       = var.zone_redundant //only for BC & Premium
  storage_account_type = var.storage_account_type
  tags                 = var.mssql_db_tags


  short_term_retention_policy {
    retention_days = var.retention_days
  }
  long_term_retention_policy {
    weekly_retention  = var.weekly_retention
    monthly_retention = var.monthly_retention
    yearly_retention  = var.yearly_retention
    week_of_year      = var.week_of_year
  }
}


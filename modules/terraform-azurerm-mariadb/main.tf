/*
* ## terraform-azurerm-mariadb
* Terraform module to create a Azure MariaDB server and database.
*
* ## Description
* Azure Database for MariaDB is a relational database service in the Microsoft cloud. Azure Database for MariaDB is based on the MariaDB community edition (available under the GPLv2 license) database engine, version 10.2 and 10.3.
*
* Azure Database for MariaDB delivers:
* - Built-in high availability with no additional cost.
* - Predictable performance, using inclusive pay-as-you-go pricing.
* - Scaling as needed within seconds.
* - Secured protection of sensitive data at rest and in motion.
* - Automatic backups and point-in-time-restore for up to 35 days.
* - Enterprise-grade security and compliance.
* 
* ## Module example use
*
* ```hcl
* module "mariadb" {
*   source = "../../modules/terraform-azurerm-mariadb"
* 
*   name                = "global unique name"
*   resource_group_name = "demo-rsg01"
*   location            = "westeurope"
*   storage_mb          = 5120
*   sku_name            = "GP_Gen5_8"
* 
*   tags = {
*     "AtosManaged" = "true"
*   }
* 
*   mariadb_databases = {
*     testdb1 = {
*       database_charset   = "utf8",
*       database_collation = "utf8_general_ci"
*     }
*   }
* }
* ```
*
* ## License
* Atos, all rights protected - 2021.
*/

# Generates secure string to be used as Admin password in case value not provided by the user
resource "random_password" "admin_password" {
  length           = 16
  special          = true
  min_upper        = 1
  min_lower        = 1
  min_numeric      = 1
  override_special = "!?_."
}

locals {
  # Create local value for admin password - if module is not provided with password will use generated one
  administrator_login_password = var.administrator_login_password == "" ? random_password.admin_password.result : var.administrator_login_password
}

resource "azurerm_mariadb_server" "mariadb_server" {
  name                          = var.name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  administrator_login           = var.administrator_login
  administrator_login_password  = local.administrator_login_password
  sku_name                      = var.sku_name
  version                       = var.mariadb_version
  storage_mb                    = var.storage_mb
  backup_retention_days         = var.backup_retention_days
  geo_redundant_backup_enabled  = var.geo_redundant_backup_enabled # This is not supported for the Basic tier.
  auto_grow_enabled             = var.auto_grow_enabled
  public_network_access_enabled = var.public_network_access_enabled
  ssl_enforcement_enabled       = var.ssl_enforcement_enabled
  tags                          = var.tags
}

resource "azurerm_mariadb_database" "mariadb_database" {
  for_each            = var.mariadb_databases
  name                = each.key
  resource_group_name = azurerm_mariadb_server.mariadb_server.resource_group_name
  server_name         = azurerm_mariadb_server.mariadb_server.name
  charset             = each.value.database_charset
  collation           = each.value.database_collation
}
/*
* ## terraform-azurerm-postgresql
* Terraform module to create a Azure PostgreSQL server and database. The current version of module supports only two deployment modes of Azure Database for PostgreSQL - Single server and Flexible server mode
* 
* ## Description
* Azure Database for PostgreSQL is a relational database service in the Microsoft cloud based on the PostgreSQL Community Edition (available under the GPLv2 license) database engine. Azure Database for PostgreSQL delivers:
* 
* - Built-in high availability.
* - Data protection using automatic backups and point-in-time-restore for up to 35 days.
* - Automated maintenance for underlying hardware, operating system and database engine to keep the service secure and up to date.
* - Predictable performance, using inclusive pay-as-you-go pricing.
* - Elastic scaling within seconds.
* - Enterprise grade security and industry-leading compliance to protect sensitive data at-rest and in-motion.
* - Monitoring and automation to simplify management and monitoring for large-scale deployments.
* - Industry-leading support experience.
* 
* Azure Database for PostgreSQL powered by the PostgreSQL community edition is available in three deployment modes:
* - Single Server
* - Flexible Server
* - Hyperscale (Citus) (Private preview - not suppported by terraform)
* - Azure Arc enabled PostgreSQL Hyperscale (Preview - not supported by terraform)
*
* ** Important note**
* As there are some substantial differences between the Single server and Flexible server deployments for PostgreSQL, some of the parameters are only available for specific modes.
* 
* Parameters are avaialble only for Single server mode
* - geo_redundant_backup_enabled
* - auto_grow_enabled
* - public_network_access_enabled
* - ssl_enforcement_enabled
* - ssl_minimal_tls_version_enforced
*
* Parameters available only for Flexible server mode
* - delegated_subnet_id
* - private_dns_zone_id
* 
* ## Module example use
*
* PostgreSQL Single server deployment
* ```hcl
* module "postgresql" {
*   source = "../../terraform-azurerm-postgresql"
* 
*   deployment_mode_flexible     = false
*   name                         = "global unique name"
*   resource_group_name          = "demo-rsg01"
*   location                     = "westeurope"
*   postgresql_version           = "11"
*   administrator_login          = "sqladministrator"
*   administrator_login_password = "Sup3rS3cur3P@ss!"
*   storage_mb                   = 32768
*   auto_grow_enabled            = true
*   sku_name                     = "GP_Gen5_4"
*
*   tags = {
*     "AtosManaged" = "true"
*   }
*
*   postgresql_databases = {
*     testdb1 = {
*       database_charset   = "UTF8"
*       database_collation = "en-US"
*     }
*     testdb2 = {
*       database_charset   = "UTF8"
*       database_collation = "en-US"
*     }
*   }
* ```
* PostgreSQL Flexible server deployment
* ```hcl
* module "postgresql" {
*   source = "../../terraform-azurerm-postgresql"
* 
*   deployment_mode_flexible     = true
*   name                         = "global unique name"
*   resource_group_name          = "demo-rsg01"
*   location                     = "westeurope"
*   postgresql_version           = "11"
*   administrator_login          = "sqladministrator"
*   administrator_login_password = "Sup3rS3cur3P@ss!"
*   storage_mb                   = 32768
*   sku_name                     = "GP_Standard_D4s_v3"
*   
*   tags = {
*     "AtosManaged" = "true"
*   }
*   
*   postgresql_databases = {
*     testdb1 = {
*       database_charset   = "UTF8"
*       database_collation = "en_US.utf8"
*     }
*     testdb2 = {
*       database_charset   = "UTF8"
*       database_collation = "en_US.utf8"
*     }
*   }
* }
* ```
*
* ## License
* Atos, all rights protected - 2021.
*/

# Generates secure string to be used as Admin password in case value not provided by the user
resource "random_password" "sql_admin_password" {
  length           = 16
  special          = true
  min_upper        = 1
  min_lower        = 1
  min_numeric      = 1
  override_special = "!?_."
}

locals {
  # Create local value for admin password - if module is not provided with password will use generated one
  administrator_login_password = var.administrator_login_password == "" ? random_password.sql_admin_password.result : var.administrator_login_password
}

resource "azurerm_postgresql_server" "postgresql_server" {
  count                            = var.deployment_mode_flexible ? 0 : 1
  name                             = var.name
  location                         = var.location
  resource_group_name              = var.resource_group_name
  administrator_login              = var.administrator_login
  administrator_login_password     = local.administrator_login_password
  sku_name                         = var.sku_name
  version                          = var.postgresql_version
  storage_mb                       = var.storage_mb
  backup_retention_days            = var.backup_retention_days
  geo_redundant_backup_enabled     = var.geo_redundant_backup_enabled // Only available for General Purpose & Memory Optimized performance tier
  auto_grow_enabled                = var.auto_grow_enabled
  public_network_access_enabled    = var.public_network_access_enabled
  ssl_enforcement_enabled          = var.ssl_enforcement_enabled
  ssl_minimal_tls_version_enforced = var.ssl_minimal_tls_version_enforced
  tags                             = var.tags
}

resource "azurerm_postgresql_flexible_server" "postgresql_server" {
  count                  = var.deployment_mode_flexible ? 1 : 0
  name                   = var.name
  location               = var.location
  resource_group_name    = var.resource_group_name
  administrator_login    = var.administrator_login
  administrator_password = local.administrator_login_password
  sku_name               = var.sku_name
  version                = var.postgresql_version
  storage_mb             = var.storage_mb
  backup_retention_days  = var.backup_retention_days
  delegated_subnet_id    = var.delegated_subnet_id
  private_dns_zone_id    = var.private_dns_zone_id
  tags                   = var.tags
}

resource "azurerm_postgresql_flexible_server_database" "postgresql_database" {
  for_each  = var.deployment_mode_flexible ? var.postgresql_databases : {}
  name      = each.key
  server_id = azurerm_postgresql_flexible_server.postgresql_server[0].id
  charset   = each.value.database_charset
  collation = each.value.database_collation
}

resource "azurerm_postgresql_database" "postgresql_database" {
  for_each            = var.deployment_mode_flexible ? {} : var.postgresql_databases
  name                = each.key
  resource_group_name = azurerm_postgresql_server.postgresql_server[0].resource_group_name
  server_name         = azurerm_postgresql_server.postgresql_server[0].name
  charset             = each.value.database_charset
  collation           = each.value.database_collation
}
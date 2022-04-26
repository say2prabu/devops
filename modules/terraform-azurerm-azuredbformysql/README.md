# terraform-azurerm-azuredbformysql
Terraform module to create an Azure MySQL Database.

## Description
Azure Database for MySQL is a relational database service in the Microsoft cloud based on the MySQL Community Edition (available under the GPLv2 license) database engine, versions 5.7, and 8.0.

Azure Database for MySQL Single Server is a fully managed database service designed for minimal customization. The single server platform is designed to handle most of the database management functions such as patching, backups, high availability, security with minimal user configuration and control.

## Module Example Use
```hcl
resource "azurerm_mysql_server" "mysqlserver" {
  name                             = "global unique name"
  resource_group_name              = "tst-msdn-d-rsg-test"
  location                         = "westeurope"
  version                          = "8.0"
  sku_name                         = "GP_Gen5_2"
  storage_mb                       = "5120"
  administrator_login              = "sqladministrator"
  administrator_login_password     = "koLNPhjsCQs87J?"
  public_network_access_enabled    = true
  ssl_enforcement_enabled          = true
  ssl_minimal_tls_version_enforced = "TLS1_2"
  backup_retention_days            = 7
  geo_redundant_backup_enabled     = false
  tags                             = {
      "AtosManaged" = "true"
  }
}

resource "azurerm_mysql_database" "mysqldb" {
  name                = "global unique name"
  resource_group_name = azurerm_mysql_server.mysqlserver.resource_group_name
  server_name         = azurerm_mysql_server.mysqlserver.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

resource "azurerm_mysql_firewall_rule" "mysqlfw" {
  for_each            = "fwrule"
  resource_group_name = azurerm_mysql_server.mysqlserver.resource_group_name
  server_name         = azurerm_mysql_server.mysqlserver.name
  ipv4_firewall_rule  = {
    name = "fwrule1"
    range_start  = "10.0.0.1"
    range_end    = "10.0.0.3"
  }
}

```

## Module Arguments

| Name                       | Type     | Required | Description                                                             |
| -------------------------- | -------- | -------- | ----------------------------------------------------------------------- |
| `name `         | `string` | true     | The name of the MySQL Server. This needs to be globally unique within Azure.                             |
| `resource_group_name`      | `string` | true     | The name of the resource group in which to create the My SQL Database. |
| `location`                 | `string` | true     | Specifies the supported Azure location where the resource exists.       |
| `mysql_version`      | `string`    | true     | The version for the new server. Valid values are: 5.7 and 8.0.                    |
| `sku_name`      | `string`    | true     | Specifies the name of the SKU used by the database. For example, B_Gen5_2, ElasticPool, Basic, S0, P2 ,DW100c, DS100.                    |
| `db_storage`      | `number`    | true     | The max size of the database in megabytes.                                |
| `administrator_login` | `string` | true | The administrator login name for the new server.|
| `administrator_login_password` | `string` | true | The password associated with the administrator_login user.|
| `ssl_minimal_tls_version_enforced` | `string` | false | Minimal TLS Version|
| `backup_retention_days` | `number` | true | Point In Time Restore configuration. Value has to be between 7 and 35.|
| `geo_redundant_backup_enabled` | `bool` | false | Turn Geo-redundant server backups on/off |
| `mysql_tags`                     | `map`    | false    | A mapping of tags to assign to the resource.                            |
| `database_name`              | `string`    | true     | The name of the MySQL Database.                                   |
| `charset`                | `string`   | false    | Specifies the charset of the database                          |
| `collation` | `string` | false    | Specifies the collation of the database                       |
| `ipv4_firewall_rule`               | `map` | false    | The name of the Firewall rule for MySQL Database and the address range (start ip address & end ip address).  |

## License
Atos, all rights protected - 2021.
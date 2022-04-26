# terraform-azurerm-azuresqldatabase
Terraform module to create Azure SQL databases (the module also creates the Azure SQL Server to host the databases on).
The module deploys 1 server but is able to deploy multiple databases using the 'name' input variable.

## Description
Azure SQL Database is a fully managed platform as a service (PaaS) database engine that handles most of the database management functions such as upgrading, patching, backups, and monitoring without user involvement.

Azure SQL Database let you easily purchase a fully managed platform as a service (PaaS) database engine that fits your performance and cost needs. Depending on the deployment model you've chosen for Azure SQL Database, you can select the purchasing model that works for you:

- Virtual core (vCore)-based purchasing model (recommended). This purchasing model provides a choice between a provisioned compute tier and a serverless compute tier. With the provisioned compute tier, you choose the exact amount of compute resources that are always provisioned for your workload. With the serverless compute tier, you specify the autoscaling of the compute resources over a configurable compute range. With this compute tier, you can also automatically pause and resume the database based on workload activity. The vCore unit price per unit of time is lower in the provisioned compute tier than it is in the serverless compute tier.

- Database transaction unit (DTU)-based purchasing model. This purchasing model provides bundled compute and storage packages balanced for common workloads.

> **Important note**: the database `zone_redundant` parameter can only be used in combination with Premium and Business Critical databases (which is set via the `sku_name` parameter).

## Module example use
```hcl

module "mssql_db" {
  source = "../../modules/terraform-azurerm-azuresqldatabase"

  name                          = "global unique name"
  resource_group_name           = "demo-rsg01"
  location                      = "westeurope"
  version                       = "12.0"
  administrator_login           = "sqladmin"
  administrator_login_password  = "Sup3rS3cur3P@ss!"
  minimum_tls_version           = "1.2"
  connection_policy             = "Default"
  public_network_access_enabled = false
  tags                          = {
      "AtosManaged" = "true"
  }

  database_name        = "demodb001"
  server_id            = azurerm_mssql_server.mssql_server.id
  collation            = "SQL_Latin1_General_CP1_CI_AS"
  license_type         = "BasePrice"
  max_size_gb          = 32
  sku_name             = "BC_Gen5_2"
  zone_redundant       = true
  storage_account_type = ZRS

  short_term_retention_policy {
    retention_days = 7
  }
  long_term_retention_policy {
    weekly_retention  = "P1Y"
    monthly_retention = "P1Y"
    yearly_retention  = "P1Y"
    week_of_year      = 52
  }
  mssql_db_tags = {
      "AtosManaged" = "true"
      "Environment" = "PreProd"
      "Application" = "HR"
  }
```

## Module Arguments

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `name` | `string` | true | The name of the MS SQL server instance. |
| `resource_group_name` | `string` | true | The name of the resource group in which to create the MS SQL server instance. |
| `location` | `string` | true | The location of the resource group. |
| `version` | `number` | true | The version for the new server. Valid values are: 2.0 (for v11 server) and 12.0 (for v12 server).|
| `administrator_login` | `string` | true | The administrator login name for the new server.|
| `administrator_login_password` | `string` | true |The password associated with the administrator_login user.|
| `minimum_tls_version` | `string` | true | The Minimum TLS Version for all SQL Database and SQL Data Warehouse databases associated with the server. Valid values are: 1.0, 1.1 and 1.2.|
| `connection_policy` | `string` | true |The connection policy the server will use. Possible values are Default, Proxy, and Redirect. Defaults to Default. |
| `public_network_access_enabled` | `string` | true | Whether public network access is allowed for this server. Defaults to true.|
| `tags` | `map` | false | A mapping of tags to assign to the resource. |
| `database_name` | `string` | true | The name of the MS SQL Database.|
| `server_id` | `string` | true | The id of the Ms SQL Server on which to create the database.|
| `collation` | `string` | true | Specifies the collation of the database.|
| `license_type` | `string` | true | Specifies the license type applied to this database. Possible values are LicenseIncluded and BasePrice.|
| `max_size_gb` | `string` | true | The max size of the database in gigabytes.|
| `sku_name` | `string` | true | Specifies the name of the SKU used by the database. For example, GP_S_Gen5_2,HS_Gen4_1,BC_Gen5_2, ElasticPool, Basic, S0, P2 ,DW100c, DS100.|
| `zone_redundant` | `string` | true | Whether or not this database is zone redundant, which means the replicas of this database will be spread across multiple availability zones. **This property is only settable for Premium and Business Critical databases.**|
| `storage_account_type` | `string` | true | Specifies the storage account type used to store backups for this database. Possible values are GRS, LRS and ZRS. The default value is GRS.|
| `retention_days` | `string` | true | Point In Time Restore configuration. Value has to be between 7 and 35.|
| `weekly_retention` | `string` | true | The weekly retention policy for an LTR backup in an ISO 8601 format. Valid value is between 1 to 520 weeks. e.g. P1Y, P1M, P1W or P7D.|
| `monthly_retention` | `string` | true | The monthly retention policy for an LTR backup in an ISO 8601 format. Valid value is between 1 to 120 months. e.g. P1Y, P1M, P4W or P30D.|
| `yearly_retention` | `string` | true | The yearly retention policy for an LTR backup in an ISO 8601 format. Valid value is between 1 to 10 years. e.g. P1Y, P12M, P52W or P365D.|
| `week_of_year` | `string` | true | The week of year to take the yearly backup in an ISO 8601 format. Value has to be between 1 and 52.|
| `mssql_db_tags` | `map` | false | A mapping of tags to assign to the database resource. |

## Module outputs

| Name | Description | Value
| --- | --- | --- |
| `sqlserver_id` | The resource id of the created SQL server instance. | `azurerm_mssql_server.mssql_server.id` |

## License
Atos, all rights protected - 2021.

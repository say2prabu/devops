# terraform-azurerm-managedsqlinstance
Terraform module to create a Managed SQL Instance.

## Description
Azure SQL Managed Instance is the intelligent, scalable cloud database service that combines the broadest SQL Server database engine compatibility with all the benefits of a fully managed and evergreen platform as a service. SQL Managed Instance has near 100% compatibility with the latest SQL Server (Enterprise Edition) database engine, providing a native virtual network (VNet) implementation that addresses common security concerns, and a business model favorable for existing SQL Server customers.

This module implements a SQL Managed Instance which will be used by both the applications; afqp & websi, for the Siemens Showcase.

## Module example use
```hcl
module "managed_sql_instance" {
  source = "../../modules/terraform-azurerm-managedsqlinstance"

  name                         = "DemoMSQLI001"
  resource_group_name          = "demo-rsg"
  location                     = "germanywestcentral"
  subnet_id                    = "<resource id of existing subnet>"
  administrator_login_password = "Sup3Secur3P@ss!"
  sku_name                     = "GP_Gen5"
  collation                    = "Democollationname"
  timezone_id                  = "UTC"
  storage_size_in_gb           = 704
  tags                = {
    "AtosManaged" = "true"
    "Environment" = "Non-prod"
  }
}

```
## Module Arguments

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `name` | `string` | true | The name of the SQL Managed Instance. This needs to be globally unique within Azure. |
| `resource_group_name` | `string` | true | The name of the resource group in which to create the SQL Server. |
| `location` | `string` | true | Specifies the supported Azure location where the resource exists. |
| `subnet_id` | `string` | true | The subnet resource id that the SQL Managed Instance will be associated with. |
| `administrator_login_password` | `string` | true | The password associated with the administrator_login user. |
| `sku_name` | `string` | true | Specifies the SKU Name for the SQL Managed Instance. Valid values include GP_Gen4, GP_Gen5, BC_Gen4, BC_Gen5. |
| `collation` | `string` | false | Specifies how the SQL Managed Instance will be collated. Default value is SQL_Latin1_General_CP1_CI_AS.|
| `timezone_id` | `string` | false | The TimeZone ID that the SQL Managed Instance will be operating in. |
| `storage_size_in_gb` | `number` | true | Maximum storage space for your instance. It should be a multiple of 32GB. |
| `tags` | `map` | false | A mapping of tags to assign to the resource. |

For a complete list of all the possible arguments (terraform variables), see the variables.tf file in this modules folder.

## Module outputs

| Name | Description | Value
| --- | --- | --- |
| `msqli_fqdn` | The fqdn of the created sql managed instance. | `azurerm_sql_managed_instance.msqli.fqdn` |
| `msqli_id` | The resource id of the created sql managed instance. | `azurerm_sql_managed_instance.msqli.id` |

## License
Atos, all rights protected - 2021.

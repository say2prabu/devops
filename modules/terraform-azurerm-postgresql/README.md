## terraform-azurerm-postgresql
Terraform module to create a Azure PostgreSQL server and database. The current version of module supports only two deployment modes of Azure Database for PostgreSQL - Single server and Flexible server mode

## Description
Azure Database for PostgreSQL is a relational database service in the Microsoft cloud based on the PostgreSQL Community Edition (available under the GPLv2 license) database engine. Azure Database for PostgreSQL delivers:

- Built-in high availability.
- Data protection using automatic backups and point-in-time-restore for up to 35 days.
- Automated maintenance for underlying hardware, operating system and database engine to keep the service secure and up to date.
- Predictable performance, using inclusive pay-as-you-go pricing.
- Elastic scaling within seconds.
- Enterprise grade security and industry-leading compliance to protect sensitive data at-rest and in-motion.
- Monitoring and automation to simplify management and monitoring for large-scale deployments.
- Industry-leading support experience.

Azure Database for PostgreSQL powered by the PostgreSQL community edition is available in three deployment modes:
- Single Server
- Flexible Server
- Hyperscale (Citus) (Private preview - not suppported by terraform)
- Azure Arc enabled PostgreSQL Hyperscale (Preview - not supported by terraform)

** Important note**
As there are some substantial differences between the Single server and Flexible server deployments for PostgreSQL, some of the parameters are only available for specific modes.

Parameters are avaialble only for Single server mode
- geo\_redundant\_backup\_enabled
- auto\_grow\_enabled
- public\_network\_access\_enabled
- ssl\_enforcement\_enabled
- ssl\_minimal\_tls\_version\_enforced

Parameters available only for Flexible server mode
- delegated\_subnet\_id
- private\_dns\_zone\_id

## Module example use

PostgreSQL Single server deployment
```hcl
module "postgresql" {
  source = "../../terraform-azurerm-postgresql"

  deployment_mode_flexible     = false
  name                         = "global unique name"
  resource_group_name          = "demo-rsg01"
  location                     = "westeurope"
  postgresql_version           = "11"
  administrator_login          = "sqladministrator"
  administrator_login_password = "Sup3rS3cur3P@ss!"
  storage_mb                   = 32768
  auto_grow_enabled            = true
  sku_name                     = "GP_Gen5_4"

  tags = {
    "AtosManaged" = "true"
  }

  postgresql_databases = {
    testdb1 = {
      database_charset   = "UTF8"
      database_collation = "en-US"
    }
    testdb2 = {
      database_charset   = "UTF8"
      database_collation = "en-US"
    }
  }
```
PostgreSQL Flexible server deployment
```hcl
module "postgresql" {
  source = "../../terraform-azurerm-postgresql"

  deployment_mode_flexible     = true
  name                         = "global unique name"
  resource_group_name          = "demo-rsg01"
  location                     = "westeurope"
  postgresql_version           = "11"
  administrator_login          = "sqladministrator"
  administrator_login_password = "Sup3rS3cur3P@ss!"
  storage_mb                   = 32768
  sku_name                     = "GP_Standard_D4s_v3"

  tags = {
    "AtosManaged" = "true"
  }

  postgresql_databases = {
    testdb1 = {
      database_charset   = "UTF8"
      database_collation = "en_US.utf8"
    }
    testdb2 = {
      database_charset   = "UTF8"
      database_collation = "en_US.utf8"
    }
  }
}
```

## License
Atos, all rights protected - 2021.

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_postgresql_database.postgresql_database](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_database) | resource |
| [azurerm_postgresql_flexible_server.postgresql_server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server) | resource |
| [azurerm_postgresql_flexible_server_database.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_database) | resource |
| [azurerm_postgresql_server.postgresql_server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_server) | resource |
| [random_password.sql_admin_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_administrator_login"></a> [administrator\_login](#input\_administrator\_login) | The administrator login name for the new server. | `string` | `"sqladministrator"` | no |
| <a name="input_administrator_login_password"></a> [administrator\_login\_password](#input\_administrator\_login\_password) | The password associated with the administrator\_login user. | `string` | `""` | no |
| <a name="input_auto_grow_enabled"></a> [auto\_grow\_enabled](#input\_auto\_grow\_enabled) | Enable/Disable auto-growing of the storage. Storage auto-grow prevents your server from running out of storage and becoming read-only. If storage auto grow is enabled, the storage automatically grows without impacting the workload. The default value if not explicitly specified is true | `bool` | `true` | no |
| <a name="input_backup_retention_days"></a> [backup\_retention\_days](#input\_backup\_retention\_days) | Backup retention days for the server, supported values are between 7 and 35 days | `number` | `7` | no |
| <a name="input_delegated_subnet_id"></a> [delegated\_subnet\_id](#input\_delegated\_subnet\_id) | value | `any` | `null` | no |
| <a name="input_deployment_mode_flexible"></a> [deployment\_mode\_flexible](#input\_deployment\_mode\_flexible) | n/a | `bool` | `false` | no |
| <a name="input_geo_redundant_backup_enabled"></a> [geo\_redundant\_backup\_enabled](#input\_geo\_redundant\_backup\_enabled) | Turn Geo-redundant server backups on/off. This allows you to choose between locally redundant or geo-redundant backup storage in the General Purpose and Memory Optimized tiers. This option is only available for single server deployment mode | `bool` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where the resource exists. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the PostgreSQL Server. This needs to be globally unique within Azure. | `string` | n/a | yes |
| <a name="input_postgresql_databases"></a> [postgresql\_databases](#input\_postgresql\_databases) | Map of maps containing config for the databases e.g. postgresql\_databases = { testdb1={ database\_charset = 'UTF8', database\_collation = 'en-US' }, testdb2 = { database\_charset = 'UTF8' database\_collation = 'en-US' }} | `map(map(string))` | n/a | yes |
| <a name="input_postgresql_version"></a> [postgresql\_version](#input\_postgresql\_version) | Specifies the version of PostgreSQL to use. Valid values are 9.5, 9.6, 10, 10.0, and 11. Changing this forces a new resource to be created. | `string` | `"11"` | no |
| <a name="input_private_dns_zone_id"></a> [private\_dns\_zone\_id](#input\_private\_dns\_zone\_id) | value | `any` | `null` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether or not public network access is allowed for this server. | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the PostgreSQL Server. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | Specifies the SKU Name for this PostgreSQL Server. The name of the SKU, follows the tier + family + cores pattern (e.g. B\_Gen4\_1, GP\_Gen5\_8) | `string` | n/a | yes |
| <a name="input_ssl_enforcement_enabled"></a> [ssl\_enforcement\_enabled](#input\_ssl\_enforcement\_enabled) | Specifies if SSL should be enforced on connections. | `bool` | `true` | no |
| <a name="input_ssl_minimal_tls_version_enforced"></a> [ssl\_minimal\_tls\_version\_enforced](#input\_ssl\_minimal\_tls\_version\_enforced) | The mimimun TLS version to support on the sever. Possible values are TLSEnforcementDisabled, TLS1\_0, TLS1\_1, and TLS1\_2. | `string` | `"TLS1_2"` | no |
| <a name="input_storage_mb"></a> [storage\_mb](#input\_storage\_mb) | The max storage allowed for the PostgreSQL Flexible Server. Possible values are 32768, 65536, 131072, 262144, 524288, 1048576, 2097152, 4194304, 8388608, 16777216, and 33554432 | `number` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_administrator_login"></a> [administrator\_login](#output\_administrator\_login) | Local admin user name |
| <a name="output_administrator_login_password"></a> [administrator\_login\_password](#output\_administrator\_login\_password) | Local admin user password |
| <a name="output_server_id"></a> [server\_id](#output\_server\_id) | n/a |

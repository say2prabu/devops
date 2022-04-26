## terraform-azurerm-mariadb
Terraform module to create a Azure MariaDB server and database.

## Description
Azure Database for MariaDB is a relational database service in the Microsoft cloud. Azure Database for MariaDB is based on the MariaDB community edition (available under the GPLv2 license) database engine, version 10.2 and 10.3.

Azure Database for MariaDB delivers:
- Built-in high availability with no additional cost.
- Predictable performance, using inclusive pay-as-you-go pricing.
- Scaling as needed within seconds.
- Secured protection of sensitive data at rest and in motion.
- Automatic backups and point-in-time-restore for up to 35 days.
- Enterprise-grade security and compliance.

## Module example use

```hcl
module "mariadb" {
  source = "../../modules/terraform-azurerm-mariadb"

  name                = "global unique name"
  resource_group_name = "demo-rsg01"
  location            = "westeurope"
  storage_mb          = 5120
  sku_name            = "GP_Gen5_8"

  tags = {
    "AtosManaged" = "true"
  }

  mariadb_databases = {
    testdb1 = {
      database_charset   = "utf8",
      database_collation = "utf8_general_ci"
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
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.86.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_mariadb_database.mariadb_database](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mariadb_database) | resource |
| [azurerm_mariadb_server.mariadb_server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mariadb_server) | resource |
| [random_password.admin_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_administrator_login"></a> [administrator\_login](#input\_administrator\_login) | The Administrator Login for the MariaDB Server. Changing this forces a new resource to be created. | `string` | `"sqladministrator"` | no |
| <a name="input_administrator_login_password"></a> [administrator\_login\_password](#input\_administrator\_login\_password) | The password associated with the administrator\_login for the MariaDB Server | `string` | `""` | no |
| <a name="input_auto_grow_enabled"></a> [auto\_grow\_enabled](#input\_auto\_grow\_enabled) | Enable/Disable auto-growing of the storage. Storage auto-grow prevents your server from running out of storage and becoming read-only. If storage auto grow is enabled, the storage automatically grows without impacting the workload. The default value if not explicitly specified is true. | `bool` | `true` | no |
| <a name="input_backup_retention_days"></a> [backup\_retention\_days](#input\_backup\_retention\_days) | Backup retention days for the server, supported values are between 7 and 35 days. | `number` | `7` | no |
| <a name="input_geo_redundant_backup_enabled"></a> [geo\_redundant\_backup\_enabled](#input\_geo\_redundant\_backup\_enabled) | Turn Geo-redundant server backups on/off. This allows you to choose between locally redundant or geo-redundant backup storage in the General Purpose and Memory Optimized tiers. When the backups are stored in geo-redundant backup storage, they are not only stored within the region in which your server is hosted, but are also replicated to a paired data center. This provides better protection and ability to restore your server in a different region in the event of a disaster. This is not supported for the Basic tier. | `bool` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where the resource exists. | `string` | n/a | yes |
| <a name="input_mariadb_databases"></a> [mariadb\_databases](#input\_mariadb\_databases) | Map of maps containing config for the databases e.g. mariadb\_databases = { testdb1={ database\_charset = 'utf8', database\_collation = 'utf8\_general\_ci' }, testdb2 = { database\_charset = 'utf8' database\_collation = 'utf8\_general\_ci' }} | `map(map(string))` | n/a | yes |
| <a name="input_mariadb_version"></a> [mariadb\_version](#input\_mariadb\_version) | Specifies the version of MariaDB to use. Possible values are 10.2 and 10.3. Changing this forces a new resource to be created. | `string` | `"10.3"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the MariaDB Server. This needs to be globally unique within Azure. | `string` | n/a | yes |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether or not public network access is allowed for this server. Defaults to true. | `bool` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the MariaDB Server. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | Specifies the SKU Name for this MariaDB Server. The name of the SKU, follows the tier + family + cores pattern (available tiers: B\_Gen5\_1 B\_Gen5\_2 GP\_Gen5\_2 GP\_Gen5\_4 GP\_Gen5\_8 GP\_Gen5\_16 GP\_Gen5\_32 MO\_Gen5\_2 MO\_Gen5\_4 MO\_Gen5\_8 MO\_Gen5\_16). | `string` | n/a | yes |
| <a name="input_ssl_enforcement_enabled"></a> [ssl\_enforcement\_enabled](#input\_ssl\_enforcement\_enabled) | Specifies if SSL should be enforced on connections. | `bool` | `true` | no |
| <a name="input_storage_mb"></a> [storage\_mb](#input\_storage\_mb) | Max storage allowed for a server. Possible values are between 5120 MB (5GB) and 1024000MB (1TB) for the Basic SKU and between 5120 MB (5GB) and 4096000 MB (4TB) for General Purpose/Memory Optimized SKUs. | `number` | `5120` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_administrator_login"></a> [administrator\_login](#output\_administrator\_login) | Local admin user name |
| <a name="output_administrator_login_password"></a> [administrator\_login\_password](#output\_administrator\_login\_password) | Local admin user password |
| <a name="output_server_id"></a> [server\_id](#output\_server\_id) | ID of the server instance |

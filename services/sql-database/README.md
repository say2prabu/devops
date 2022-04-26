# terraform-azurerm-azuredbformysql
Terraform module to create an Azure MySQL Database.

## Description
Azure Database for MySQL is a relational database service in the Microsoft cloud based on the MySQL Community Edition (available under the GPLv2 license) database engine, versions 5.7, and 8.0.

Azure Database for MySQL Single Server is a fully managed database service designed for minimal customization. The single server platform is designed to handle most of the database management functions such as patching, backups, high availability, security with minimal user configuration and control.


## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_mssql_db"></a> [mssql\_db](#module\_mssql\_db) | ../../modules/terraform-azurerm-azuresqldatabase | n/a |
| <a name="module_naming"></a> [naming](#module\_naming) | ../../modules/terraform-naming | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azure_region"></a> [azure\_region](#input\_azure\_region) | The Azure location/region to which the resources are being deployed. This will be used to get the corresponding four character Atos code according to Atos DCS naming convention. | `string` | n/a | yes |
| <a name="input_environment-code"></a> [environment-code](#input\_environment-code) | A one character Atos code according to Atos DCS naming convention to indicate which environment type will be deployed to. Example 'd' for Development, 't' for Test etc. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where the resource exists. | `string` | n/a | yes |
| <a name="input_name_mssql"></a> [name\_mssql](#input\_name\_mssql) | variable "version" { type = string } variable "administrator\_login" { type = string } variable "administrator\_login\_password" { type = string } variable "minimum\_tls\_version" { type = string } variable "connection\_policy" { type = string } variable "public\_network\_access\_enabled" { type = string } | `string` | n/a | yes |
| <a name="input_organization-code"></a> [organization-code](#input\_organization-code) | A three character Atos code according to Atos DCS naming convention indicating which organization we are deploying this automation for. When for Atos use: ats | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the Microsoft SQL Server. | `string` | n/a | yes |
| <a name="input_subscription-code"></a> [subscription-code](#input\_subscription-code) | A four character Atos code according to Atos DCS naming convention to indicate which subscription we are deploying the automation to. Example 'mgmt' for management, 'lnd1' for the 1st landingzone. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | n/a |

## License
Atos, all rights protected - 2021.
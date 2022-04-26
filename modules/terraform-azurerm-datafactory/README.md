# terraform-azurerm-datafactory
Terraform module to create data factory resource

## Description
Azure Data Factory is Azure's cloud ETL service for scale-out serverless data integration and data transformation. It offers a code-free UI for intuitive authoring and single-pane-of-glass monitoring and management. You can also lift and shift existing SSIS packages to Azure and run them with full compatibility in ADF. SSIS Integration Runtime offers a fully managed service, so you don't have to worry about infrastructure management.

This module deploys Data Factory resource with an optional self hosted integration run time and sftp linked services.

## Module example use
```hcl
module "data_factory" {
  source = "../modules/terraform-azurerm-datafactory"
  datafactory_name         = "rbtestdf"
  location                 = module.df_resourcegroup.rsg_location
  resource_group_name      = module.df_resourcegroup.rsg_name
  tags                     = var.rsg_tags
  adf_ir_name              = var.adf_ir_name
  adf_linked_services_sftp = var.adf_linked_services_sftp
}

```
## Module Arguments

| Name                                    | Type     | Required | Description                                                               |
| ----------------------------------------| -------- | -------- | ------------------------------------------------------------------------- |
| `datafactory_name `                     | `string` | true     | Specifies the name of the data factory resource.                          |
| `resource_group_name`                   | `string` | true     | The name of the resource group in which to create data factory resource.  |
| `location`                              | `string` | true     | Specifies the supported Azure location where the resource exists.         |
| `tags`                                  | `map`    | false    | A mapping of tags to assign to the resource.                              |
| `adf_ir_name`                           | `string` | true     | adf Integration runtime name                                              |
| `adf_linked_services_sftp`              | `object` | true     | adf linked services sftp details                                          |

## Module outputs

| Name        | Description                                                                   | Value                                 |
| ----------- | ----------------------------------------------------------------------------- | ------------------------------------- |
| `name`      | The name of the created data factory resource                                 | `azurerm_data_factory.main.name`      |
| `location`  | The location (Azure region) where the data factory resource has been created  | `azurerm_data_factory.main.location`  |
| `id`        | The resource ID of the created data factory resource.                         | `azurerm_data_factory.main.id`        |

## License
Atos, all rights protected - 2021.
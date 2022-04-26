# terraform-azurerm-databricks
Terraform module to create data bricks resource

## Description
Azure Databricks is optimized for Azure and tightly integrated with Azure Data Lake Storage, Azure Data Factory, Azure Machine Learning, Azure Synapse Analytics, Power BI and other Azure services to store all of your data on a simple, open lakehouse and unify all of your analytics and AI workloads.

This module deploys Data bricks resource. Part of Data Bricks deployment a managed resource group gets created, with this module you can customise the resource group name and storage account in it. The module also takes custom parameters to set vnet integration with public and private subnets. You should assign network security groups to the subnets.

## Module example use
```hcl
module "data_bricks" {
  source                                               = "../modules/terraform-azurerm-databricks"
  databricks_name                                      = "databricks-rb-test3"
  resource_group_name                                  = module.df_resourcegroup.rsg_name
  location                                             = module.df_resourcegroup.rsg_location
  sku                                                  = var.databricks_sku
  managed_databricks_rg_name                           = var.databricks_managed_rg_name
  tags                                                 = var.rsg_tags
  databricks_storage_account_name                      = var.databricks_storage_account_name
  virtual_network_id                                   = data.azurerm_virtual_network.vnet.id
  public_subnet_name                                   = var.databricks_public_subnet_name
  private_subnet_name                                  = var.databricks_private_subnet_name
  public_subnet_network_security_group_association_id  = data.azurerm_network_security_group.public_subnet_nsg.id
  private_subnet_network_security_group_association_id = data.azurerm_network_security_group.private_subnet_nsg.id

}

```
## Module Arguments

| Name                                                    | Type     | Required | Description                                                             |
| ------------------------------------------------------- | -------- | -------- | ----------------------------------------------------------------------- |
| `databricks_name `                                      | `string` | true     | Specifies the name of the data bricks resource.                         |
| `resource_group_name`                                   | `string` | true     | The name of the resource group in which to create data bricks resource. |
| `location`                                              | `string` | true     | Specifies the supported Azure location where the resource exists.       |
| `sku`                                                   | `string` | true     | Defines the sku of the data bricks                                      |
| `tags`                                                  | `map`    | false    | A mapping of tags to assign to the resource.                            |
| `managed_databricks_rg_name `                           | `string` | true     | Defines custom name of the managed db rg name                           |
| `databricks_storage_account_name `                      | `string` | true     | name of the db stroge account name.                                     |
| `virtual_network_id`                                    | `string` | false    | Specifies virtual network id for the databricks                         |
| `public_subnet_name`                                    | `string` | false    | Specifies name of the public subnet_name.                               |
| `private_subnet_name`                                   | `string` | false    | specifies the name of the priviate subnet_name                          |
| `public_subnet_network_security_group_association_id`   | `string` | true     | Specifies nsg id for public subnet.                                     |
| `private_subnet_network_security_group_association_id`  | `string` | true     | Specifies nsg id for private subnet                                     |

## Module outputs

| Name                  | Description                                                                 | Value                                         |
| --------------------- | --------------------------------------------------------------------------- | --------------------------------------------- |
| `databricks_name`     | The name of the created databrick resource                                  | `azurerm_databricks_workspace.main.name`      |
| `databricks_location` | The location (Azure region) where the databricks resource has been created  | `azurerm_databricks_workspace.main.location`  |
| `databricks_id`       | The resource ID of the created databricks resource.                         | `azurerm_databricks_workspace.main.id`        |

## License
Atos, all rights protected - 2021.
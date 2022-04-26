# terraform-azurerm-storageaccount
Terraform module to create an Azure Storage Account with blob containers & file shares.

## Description
An Azure storage account contains all of Azure Storage data objects: blobs, file shares, queues, tables, and disks. The storage account provides a unique namespace for your Azure Storage data that's accessible from anywhere in the world over HTTP or HTTPS. 

This module will create a Storage account with blob containers, file shares, tables and/or queues.
It also can create a Data Lake Gen2 storage account. Blob & container retention options are not supported with a Data Lake, all input parameters are ignored if the Data Lake parameter/variable (`is_hns_enabled`) is set to true.

## Module Example Use
```hcl
module "storage_account" {
  source = "../../modules/terraform-azurerm-storageaccount"

  name                              = "demosa240921"
  resource_group_name               = "demo-rsg"
  location                          = "westeurope"
  account_kind                      = "StorageV2"
  account_tier                      = "Standard"
  account_replication_type          = "ZRS"
  access_tier                       = "Hot"
  is_hns_enabled                    = true
  allow_blob_public_access          = false
  shared_access_key_enabled         = true
  blob_delete_retention_policy      = 7
  container_delete_retention_policy = 8
  container_name                    = ["container01", "container02", "container05"]
  container_access_type             = "private"
  share_name                        = ["share01", "share02", "share03"]
  share_quota                       = 100
  queue_name                        = ["queue01", "queue02"]
  table_name                        = ["table01"]
  default_action                    = "Deny"
  ip_rules                          = ["xxx.xxx.xxx.xxx"]
  bypass                            = ["AzureServices", "Logging", "Metrics"]
  tags                              = {
    "AtosManaged" = "true"
    "Environment" = "Acceptance"
  }
}

```
## Module Arguments

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `name` | `string` | true | Specifies the name of the storage account. |
| `resource_group_name ` | `string` | true | The name of the resource group in which to create the storage account. |
| `location` | `string` | true | Specifies the supported Azure location where the resource exists. |
| `account_kind` | `string` | true | Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. |
| `account_tier` | `string` | true | TDefines the Tier to use for this storage account. Valid options are Standard and Premium. |
| `account_replication_type` | `string` | true | Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS. |
| `access_tier` | `string` | true | Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. Valid options are Hot and Cool. |
| `is_hns_enabled` | `bool` | true | Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2. This can only be true when account_tier is Standard or when account_tier is Premium and account_kind is BlockBlobStorage. |
| `allow_blob_public_access` | `bool` | false | Boolean flag to allow or disallow public access to all blobs or containers in the storage account. |
| `shared_access_key_enabled` | `bool` | false | Boolean flag which indicates whether the storage account permits requests to be authorized with the account access key via Shared Key. |
| `blob_delete_retention_policy ` | `number` | false | Specifies the number of days that the blob should be retained in days. |
| `container_delete_retention_policy` | `number` | false | Specifies the number of days that the container should be retained in days. |
| `container_name` | `set(string)` | true | The name of the container(s) which should be created within the Storage Account. |
| `container_access_type` | `string` | true | The Access Level configured for this Container. Possible values are blob, container or private. Defaults to private. |
| `share_name` | `set(string)` | true | The name of the share(s). Must be unique within the storage account where the share is located. |
| `share_quota` | `number` | true | The maximum size of the share, in gigabytes. |
| `default_action` | `string` | true | Specifies the default action of allow or deny when no other rules match. Valid options are Deny or Allow. |
| `queue_name` | `set(string)` | true | The name of the queue(s). Must be unique within the storage account where the queue is located. |
| `table_name` | `set(string)` | true | The name of the table(s). Must be unique within the storage account where the table is located. |
| `ip_rules` | `list(any)` | false | List of public IP or IP ranges in CIDR Format. Only IPV4 addresses are allowed. Private IP address ranges (as defined in RFC 1918) are not allowed. |
| `bypass` | `list(any)` | false | Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of Logging, Metrics, AzureServices, or None. |
| `tags` | `map` | false | A mapping of tags to assign to the resource. |

For a complete list of all the possible arguments (terraform variables), see the variables.tf file in this modules folder.

## Module outputs

| Name | Description | Value
| --- | --- | --- |
| `sa_id` | The resource ID of the created storage account. | `azurerm_storage_account.sa.id` |
| `sa_name` | The name of the created storage account. | `azurerm_storage_account.sa.name` |

## License
Atos, all rights protected - 2021.
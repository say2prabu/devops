# terraform-azurerm-cosmosdb
Terraform module to create an Azure Storage Account with blob containers & file shares.

## Description
The Azure Cosmos DB API for MongoDB makes it easy to use Cosmos DB as if it were a MongoDB database. You can leverage your MongoDB experience and continue to use your favorite MongoDB drivers, SDKs, and tools by pointing your application to the API for MongoDB account's connection string.

This module will create a CosmosDB Account with API for MongoDB as per Siemens requirements. Also as part of the deployment, a default Mongo database and a Mongo collection will be created. Settings of the deployment (such as backup interval and retention, Mongo server version, etc) can be set as parameters during deployment

## Module Example Use
```hcl
module "cosmosdb" {
  source = "../../modules/terraform-azurerm-cosmosdb"

  cosmos_name         = "cu1-lnd1-d-cosmos001"
  resource_group_name = "cu1-lnd1-d-rsg-cosmosdb"
  location            = "westeurope"
  dbname              = "cu1-lnd1-d-mongodb001"
  collection_name     = "cu1-lnd1-d-mongocoll001"
  offer_type          = "Standard"
  interval_in_minutes = "60"
  retention_in_hours  = "8"
  default_ttl_seconds = "777"
  shard_key           = "UniqueKey"
  tags = {
    "AtosManaged" = "true"
    "Environment" = "Acceptance"
  }
}

```

## Module Arguments

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `cosmos_name` | `string` | true | Name of the CosmosDB account that will be deployed. |
| `resource_group_name` | `string` | true | The name of the resource group in which to create the CosmosDB account. |
| `location` | `string` | true | Resource Group location. |
| `dbname` | `string` | true | Name of the Mongo database that will be deployed. |
| `collection_name` | `string` | true | Name of the Mongo collection |
| `offer_type` | `string` | true | Specifies the Offer Type to use for this CosmosDB Account - currently this can only be set to Standard. |
| `interval_in_minutes` | `string` | false |The interval in minutes between two backups. This is configurable only when type is Periodic. Possible values are between 60 and 1440. |
| `retention_in_hours` | `string` | false | The time in hours that each backup is retained. This is configurable only when type is Periodic. Possible values are between 8 and 720. |
| `default_ttl_seconds` | `number` | true | The default Time To Live in seconds for collection |
| `shard_key` | `string` | true | The name of the key to partition on for sharding. There must not be any other unique index keys |
| `tags` | `map` | false | A mapping of tags to assign to the resource. |

For a complete list of all the possible arguments (terraform variables), see the variables.tf file in this modules folder.
## Module outputs

| Name | Description | Value
| --- | --- | --- |
| `cosmos_id` | The resource ID of the created CosmosDB account. | `azurerm_cosmosdb_account.acc.id` |
| `cosmos_name` | The name of the created CosmosBD account. | `azurerm_cosmosdb_account.acc.name` |

## License
Atos, all rights protected - 2021.
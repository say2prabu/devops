#CosmosDB account
resource "azurerm_cosmosdb_account" "acc" {

  name                      = var.name
  location                  = var.location
  resource_group_name       = var.resource_group_name
#  offer_type               = var.offer_type
  offer_type                = "Standard"
  kind                      = "MongoDB"
#  kind                      = var.kind == "Mongo" ? "MongoDB" : "GlobalDocumentDB"
  enable_automatic_failover = false
#  mongo_server_version      = var.kind == "Mongo" ? var.mongo_server_version : null
  tags                      = var.tags

#  capabilities {
#    name = "${"Enable"}${var.kind}"
#  }

#  capabilities {
#    name = "EnableAggregationPipeline"
#  }

#  capabilities {
#    name = "mongoEnableDocLevelTTL"
#  }

#  capabilities {
#    name = "MongoDBv3.4"
#  }

  capabilities {
    name = "EnableMongo"
  }
  
# capabilities {
#    name = "EnableServerless"
#  }

  consistency_policy {
    consistency_level       = var.consistency_level
    max_interval_in_seconds = var.consistency_level == "BoundedStaleness" ? var.max_interval_in_seconds : null
    max_staleness_prefix    = var.consistency_level == "BoundedStaleness" ? var.max_staleness_prefix : null
  }
  geo_location {
    location          = var.location
    failover_priority = 0
  }
#  backup {
#    type                = "Periodic"
#    interval_in_minutes = var.interval_in_minutes
#    retention_in_hours  = var.retention_in_hours
#  }
}

#Database
resource "azurerm_cosmosdb_mongo_database" "mongodb" {
  count               = var.kind == "Mongo" ? 1 : 0
  name                = var.dbname
  resource_group_name = azurerm_cosmosdb_account.acc.resource_group_name
  account_name        = azurerm_cosmosdb_account.acc.name
  throughput          = 400
}

#Collection
resource "azurerm_cosmosdb_mongo_collection" "coll" {
 count               = var.kind == "Mongo" ? 1 : 0
  name                = var.collection_name
  resource_group_name = azurerm_cosmosdb_account.acc.resource_group_name
  account_name        = azurerm_cosmosdb_account.acc.name
  database_name       = azurerm_cosmosdb_mongo_database.mongodb[count.index].name

  default_ttl_seconds = var.default_ttl_seconds
  shard_key           = var.shard_key
  throughput          = 400
  
  #added throughput
#  throughput = var.throughput
#  index {
#    keys = [
#      "_id"
#    ]
#    unique = true
#  }

  depends_on = [azurerm_cosmosdb_mongo_database.mongodb]
}

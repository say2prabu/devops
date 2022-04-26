output "id" {
    description = "ID of the CosmosDB resource"
    value = module.cosmosdb.cosmosdb_id
}

output "cosmosdb_name" {
    description = "Name of the CosmosDB resource"
    value = module.cosmosdb.cosmosdb_name
}

output "cosmosdb_id" {
    description = "ID of the CosmosDB resource"
    value = azurerm_cosmosdb_account.acc.id
}

output "cosmosdb_name" {
    description = "Name of the CosmosDB resource"
    value = azurerm_cosmosdb_account.acc.name
}
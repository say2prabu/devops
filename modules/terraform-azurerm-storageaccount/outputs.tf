output "sa_id" {
    description = "ID of the storage account"
    value = azurerm_storage_account.sa.id
}

output "sa_name" {
    description = "Name of the storage account"
    value = azurerm_storage_account.sa.name
}
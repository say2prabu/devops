
output "id" {
  description = "Virtual machine ID"
  value       = azurerm_linux_virtual_machine.main[*].id
}

output "primary_blob_endpoint" {
  description = "BD Storage Account Endpoint"
  value       = azurerm_storage_account.BDstorageaccount.primary_blob_endpoint
}

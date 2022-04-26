output "storage1_account_id" {
  description = "The resource id of the created storage account."
  value = module.storage1_account.sa_id
}
output "storage1_account_name" {
  description = "The name of the created storage account."
  value = module.storage1_account.sa_name
}

output "storage2_account_id" {
  description = "The resource id of the created storage account."
  value = module.storage2_account.sa_id
}
output "storage2_account_name" {
  description = "The name of the created storage account."
  value = module.storage2_account.sa_name
}
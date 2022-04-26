/*
output "managedsqlinstance_id" {
  description = "The resource id of the created managed sql instance."
  value = module.msqli.msqli_id
}
output "managedsqlinstance_fqdn" {
  description = "The fqdn of the created managed sql instance."
  value = module.msqli.msqli_fqdn
}
*/
output "afqp_storageaccount_id" {
  description = "The resource id of the created storage account."
  value = module.afqp_storage_account.sa_id
}
output "afqp_storageaccount_name" {
  description = "The name of the created storage account."
  value = module.afqp_storage_account.sa_name
}
output "afqp_storageaccount_privateendpoint_id" {
    description = "The resource id of the created private endpoint."
    value = module.afqp_sa_privateendpoint.private_endpoint_id
}
output "afqp_storageaccount_privateendpoint_name" {
    description = "The name of the created private endpoint."
    value = module.afqp_sa_privateendpoint.private_endpoint_name
}
output "websi_storageaccount_id" {
  description = "The resource id of the created storage account."
  value = module.websi_storage_account.sa_id
}
output "websi_storageaccount_name" {
  description = "The name of the created storage account."
  value = module.websi_storage_account.sa_name
}
output "websi_storageaccount_privateendpoint_id" {
    description = "The resource id of the created private endpoint."
    value = module.websi_sa_privateendpoint.private_endpoint_id
}
output "websi_storageaccount_privateendpoint_name" {
    description = "The name of the created private endpoint."
    value = module.websi_sa_privateendpoint.private_endpoint_name
}
output "afqp_rediscache_name" {
  description = "The name of the created redis cache instance."
  value = module.afqp_redis_cache.redis_name
}
output "afqp_rediscache_id" {
  description = "The resource id of the created redis cache instance."
  value = module.afqp_redis_cache.redis_id
}
output "afqp_rediscache_privateendpoint_id" {
    description = "The resource id of the created private endpoint."
    value = module.afqp_rediscache_privateendpoint.private_endpoint_id
}
output "afqp_rediscache_privateendpoint_name" {
    description = "The name of the created private endpoint."
    value = module.afqp_rediscache_privateendpoint.private_endpoint_name
}
output "websi_rediscache_name" {
  description = "The name of the created redis cache instance."
  value = module.websi_redis_cache.redis_name
}
output "websi_rediscache_id" {
  description = "The resource id of the created redis cache instance."
  value = module.websi_redis_cache.redis_id
}
output "websi_rediscache_privateendpoint_id" {
    description = "The resource id of the created private endpoint."
    value = module.websi_rediscache_privateendpoint.private_endpoint_id
}
output "websi_rediscache_privateendpoint_name" {
    description = "The name of the created private endpoint."
    value = module.websi_rediscache_privateendpoint.private_endpoint_name
}
output "afqp_appinsights_afqp_id" {
  description = "The resource id of the created app insights."
  value = module.afqp_app_insights.id
}
output "websi_appservice_afqp_id" {
  description = "The resource id of the created app service."
  value = module.websi_app_service.id
}
output "appserviceplan_id" {
  description = "The resource id of the created app service plan."
  value = module.appservice_plan.id
}
output "afqp_appsvc_privateendpoint_id" {
    description = "The resource id of the created private endpoint."
    value = module.afqp_app_service_privateendpoint.private_endpoint_id
}
output "afqp_appsvc_privateendpoint_name" {
    description = "The name of the created private endpoint."
    value = module.afqp_app_service_privateendpoint.private_endpoint_name
}
output "websi_appsvc_privateendpoint_id" {
    description = "The resource id of the created private endpoint."
    value = module.websi_app_service_privateendpoint.private_endpoint_id
}
output "websi_appsvc_privateendpoint_name" {
    description = "The name of the created private endpoint."
    value = module.websi_app_service_privateendpoint.private_endpoint_name
}
output "cosmosdb_id" {
  description = "The resource id of the created cosmosdb instance."
  value = module.cosmosdb.cosmosdb_id
}
output "cosmosdb_name" {
  description = "The name of the created cosmosdb instance."
  value = module.cosmosdb.cosmosdb_name
}
output "cosmosdb_privateendpoint_id" {
    description = "The resource id of the created private endpoint."
    value = module.cosmosdb_privateendpoint.private_endpoint_id
}
output "cosmosdb_privateendpoint_name" {
    description = "The name of the created private endpoint."
    value = module.cosmosdb_privateendpoint.private_endpoint_name
}
/*
output "afqp_appsvc_publish_profile" {

}

output "websi_appsvc_publish_profile" {

}
*/

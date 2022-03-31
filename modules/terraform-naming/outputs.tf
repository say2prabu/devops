output "azure_region" {
  value = var.azure_region
}
output "region_code" {
  value = local.region_code
}
output "resource_group" {
  value = local.az.resource_group
}
output "standard_prefix" {
  value = local.standard_prefix
}
output "standard_withregion_prefix" {
  value = local.standard_withregion_prefix
}

output "app_service" {
  value = local.az.app_service
}
output "app_service_plan" {
  value = local.az.app_service_plan
}
output "application_gateway" {
  value = local.az.application_gateway
}
output "application_insights" {
  value = local.az.application_insights
}
output "cosmosdb_account" {
  value = local.az.cosmosdb_account
}
output "data_factory" {
  value = local.az.data_factory
}
output "data_bricks" {
  value = local.az.data_bricks
}
output "function_app" {
  value = local.az.function_app
}
output "managed_private_endpoint" {
  value = local.az.managed_private_endpoint
}
output "managed_sql_instance" {
  value = local.az.managed_sql_instance
}
output "mssql_server" {
  value = local.az.mssql_server
}
output "private_endpoint" {
  value = local.az.private_endpoint
}
output "private_dns_zone_group_name" {
  value = local.az.private_dns_zone_group_name
}
output "private_service_connection" {
  value = local.az.private_service_connection
}
output "private_link_hub" {
  value = local.az.private_link_hub
}
output "redis_cache" {
  value = local.az.redis_cache
}
output "storage_account" {
  value = local.az.storage_account
}
output "virtual_machine_linux" {
  value = local.az.virtual_machine_linux
}
output "virtual_machine_windows" {
  value = local.az.virtual_machine_windows
}
output "vm_scaleset" {
  value = local.az.vm_scaleset
}
output "analysis_services" {
  value = local.az.analysis_services
}
output "mysql_server" {
  value = local.az.mysql_server
}
output "postgresql_server" {
  value = local.az.postgresql_server
}
output "mariadb_server" {
  value = local.az.mariadb_server
}
output "keyvault" {
  value = local.az.keyvault
}
output "loadbalancer" {
  value = local.az.loadbalancer
}
output "kubernetes_service" {
  value = local.az.kubernetes_service
}
output "container_registry" {
  value = local.az.container_registry
}

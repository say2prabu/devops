output "name" {
  value = azurerm_redis_cache.redis_cache.name
}

output "id" {
  value = azurerm_redis_cache.redis_cache.id
}

output "hostname" {
  description = "The Hostname of the Redis Instance"
  value       = azurerm_redis_cache.redis_cache.hostname
}

output "ssl_port" {
  description = " The SSL Port of Redis Instance"
  value       = azurerm_redis_cache.redis_cache.ssl_port
}

output "port" {
  description = "The non-SSL Port of the Redis Instance"
  value       = azurerm_redis_cache.redis_cache.port
}

output "primary_access_key" {
  description = "The Primary Access Key for the Redis Instance"
  value       = azurerm_redis_cache.redis_cache.primary_access_key
  sensitive   = true
}

output "secondary_access_key" {
  description = "The Secondary Access Key for the Redis Instance"
  value       = azurerm_redis_cache.redis_cache.secondary_access_key
  sensitive   = true
}
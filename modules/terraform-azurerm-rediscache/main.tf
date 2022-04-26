/*
* ## terraform-azurerm-rediscache
* Terraform module to create a Azure Cache for Redis instance.
* 
* ## Description
* Azure Cache for Redis provides an in-memory data store based on the Redis software. 
* Redis improves the performance and scalability of an application that uses backend data stores heavily.
* 
* ## Module example use
* ```hcl
* module "redis_cache" {
*   source = "../../modules/terraform-azurerm-rediscache"
* 
*   name                = "demorediscache001"
*   resource_group_name = "demo-rsg"
*   location            = "westeurope"
*   capacity            = 0
*   sku_name            = "Standard"
*   tags                = {
*     "AtosManaged" = "true"
*     "Environment" = "Non-prod"
*   }
* }
* ```
*
* ## License
* Atos, all rights protected - 2021.
*/

resource "azurerm_redis_cache" "redis_cache" {
  name                          = var.name # NOTE: the Name used for Redis needs to be globally unique
  location                      = var.location
  resource_group_name           = var.resource_group_name
  capacity                      = var.capacity
  family                        = var.family[var.sku_name]
  sku_name                      = var.sku_name
  redis_version                 = var.redis_version
  public_network_access_enabled = var.public_network_access_enabled
  enable_non_ssl_port           = var.enable_non_ssl_port
  minimum_tls_version           = var.minimum_tls_version
  shard_count                   = var.shard_count
  replicas_per_master           = var.replicas_per_master
  subnet_id                     = var.subnet_id
  tags                          = var.tags

  redis_configuration {}

}

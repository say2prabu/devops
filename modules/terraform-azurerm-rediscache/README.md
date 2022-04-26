## terraform-azurerm-rediscache
Terraform module to create a Azure Cache for Redis instance.

## Description
Azure Cache for Redis provides an in-memory data store based on the Redis software.
Redis improves the performance and scalability of an application that uses backend data stores heavily.

## Module example use
```hcl
module "redis_cache" {
  source = "../../modules/terraform-azurerm-rediscache"

  name                = "demorediscache001"
  resource_group_name = "demo-rsg"
  location            = "westeurope"
  capacity            = 0
  family              = "C"
  sku_name            = "Standard"
  tags                = {
    "AtosManaged" = "true"
    "Environment" = "Non-prod"
  }
}
```

## License
Atos, all rights protected - 2021.

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_redis_cache.redis_cache](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/redis_cache) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_capacity"></a> [capacity](#input\_capacity) | The size of the Redis cache to deploy. Valid values for a SKU family of C (Basic/Standard) are 0, 1, 2, 3, 4, 5, 6, and for P (Premium) family are 1, 2, 3, 4. | `number` | n/a | yes |
| <a name="input_enable_non_ssl_port"></a> [enable\_non\_ssl\_port](#input\_enable\_non\_ssl\_port) | Whether the SSL port is enabled. | `bool` | `false` | no |
| <a name="input_family"></a> [family](#input\_family) | The SKU family/pricing group to use. Valid values are C (for Basic/Standard SKU family) and P (for Premium). | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The Azure Region in which the Redis cache should be created. | `string` | n/a | yes |
| <a name="input_minimum_tls_version"></a> [minimum\_tls\_version](#input\_minimum\_tls\_version) | The minimum TLS version. | `string` | `"1.2"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the Redis instance. | `string` | n/a | yes |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether or not public network access is allowed for this Redis Cache. | `bool` | `false` | no |
| <a name="input_redis_version"></a> [redis\_version](#input\_redis\_version) | Redis version. Only major version needed. Valid values: 4, 6. | `any` | `null` | no |
| <a name="input_replicas_per_master"></a> [replicas\_per\_master](#input\_replicas\_per\_master) | Amount of replicas to create per master for this Redis Cache. | `any` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the redis cache instance. | `string` | n/a | yes |
| <a name="input_shard_count"></a> [shard\_count](#input\_shard\_count) | Only available when using the Premium SKU The number of Shards to create on the Redis Cluster. | `number` | `null` | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The SKU of Redis to use. Possible values are Basic, Standard and Premium. | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Only available when using the Premium SKU The ID of the Subnet within which the Redis Cache should be deployed. This Subnet must only contain Azure Cache for Redis instances without any other type of resources. Changing this forces a new resource to be created. | `any` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_hostname"></a> [hostname](#output\_hostname) | The Hostname of the Redis Instance |
| <a name="output_port"></a> [port](#output\_port) | The non-SSL Port of the Redis Instance |
| <a name="output_primary_access_key"></a> [primary\_access\_key](#output\_primary\_access\_key) | The Primary Access Key for the Redis Instance |
| <a name="output_redis_id"></a> [redis\_id](#output\_redis\_id) | n/a |
| <a name="output_redis_name"></a> [redis\_name](#output\_redis\_name) | n/a |
| <a name="output_secondary_access_key"></a> [secondary\_access\_key](#output\_secondary\_access\_key) | The Secondary Access Key for the Redis Instance |
| <a name="output_ssl_port"></a> [ssl\_port](#output\_ssl\_port) | The SSL Port of Redis Instance |

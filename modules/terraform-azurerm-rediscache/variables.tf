variable "name" {
  type        = string
  description = "The name of the Redis instance."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the redis cache instance."
}

variable "location" {
  type        = string
  description = "The Azure Region in which the Redis cache should be created."
}

variable "sku_name" {
  type        = string
  description = "The SKU of Redis to use. Possible values are Basic, Standard and Premium."
}

variable "family" {
  type        = map(string)
  description = "The SKU family/pricing group to use. Deployment will pick it up basing on sku_name variable"

  default = {
    Basic    = "C"
    Standard = "C"
    Premium  = "P"
  }
}

variable "capacity" {
  type        = number
  description = "The size of the Redis cache to deploy. Valid values for a SKU family of C (Basic/Standard) are 0, 1, 2, 3, 4, 5, 6, and for P (Premium) family are 1, 2, 3, 4."
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Whether or not public network access is allowed for this Redis Cache."
  default     = false
}

variable "enable_non_ssl_port" {
  type        = bool
  description = "Whether the SSL port is enabled."
  default     = false
}

variable "minimum_tls_version" {
  type        = string
  description = "The minimum TLS version."
  default     = "1.2"
}

variable "tags" {
  type = map(string)
}

variable "shard_count" {
  type        = number
  description = "Only available when using the Premium SKU The number of Shards to create on the Redis Cluster."
  default     = null
}

variable "subnet_id" {
  description = "Only available when using the Premium SKU The ID of the Subnet within which the Redis Cache should be deployed. This Subnet must only contain Azure Cache for Redis instances without any other type of resources. Changing this forces a new resource to be created."
  default     = null
}

variable "redis_version" {
  description = "Redis version. Only major version needed. Valid values: 4, 6."
  default     = null
}

variable "replicas_per_master" {
  description = "Amount of replicas to create per master for this Redis Cache."
  default     = null
}
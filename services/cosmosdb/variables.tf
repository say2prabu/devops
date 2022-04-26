variable "azure_region" {
  type = string
}

variable "organization_code" {
  type = string
}

variable "environment_code" {
  type = string
}

variable "subscription_code" {
  type = string
}
variable "resource_group_name"{
    type = string
}
variable "location"{
    type = string
}
variable "offer_type" {
  type = string
  default =  "Standard"
}

variable "dbname" {
  type = string
  description = "Mongo DB Name"
  default = "database_name"
}
variable "collection_name" {
  type = string
  description = "Mongo DB Collection Name"
  default = "collection_name1"
}
variable "default_ttl_seconds" {
  type = number
  description = "TTL in seconds for DB collection. (Example 777) The default Time To Live in seconds. If the value is -1 or 0, items are not automatically expired. required"
  default = 777
}
variable "shard_key" {
  type = string
  description = "The name of the key to partition on for sharding. There must not be any other unique index keys (example: UniqueKey) required"
  default = "UniqueKey"
}

variable "interval_in_minutes" {
  type = number
  description = "Backup interval in minutes for CosmosDB.Possible values are between 60 and 1440"
  default = null
}
variable "retention_in_hours" {
  type = number
  description = "Backup retention in hours for CosmosDB.Possible values are between 8 and 720"
  default = null
}

variable "cosmosdb_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default = {
    "AtosManaged" = "true"
  }
}
# variable "throughput" {
#   type = number
#   description = " The throughput of the MongoDB collection (RU/s). Must be set in increments of 100. The minimum value is 400. This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply."
# }

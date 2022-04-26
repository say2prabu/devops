variable "name" {
  type = string
  description = "Specifies the name of the CosmosDB Account."
}
variable "location" {
  type = string
  description = "Specifies the supported Azure location where the resource exists."
}
variable "resource_group_name" {
  type = string
  description = "The name of the resource group in which the CosmosDB Account is created."
}
variable "offer_type" {
  type = string
  description = "Specifies the Offer Type to use for this CosmosDB Account - currently this can only be set to Standard."
  default = "Standard"
}
variable "kind" {
  type = string
  description = "Specifies the Kind of CosmosDB to create - possible values are GlobalDocumentDB and MongoDB."
  default = "Mongo"
}
# variable "mongo_server_version" {
#   type = string
#   description = "Server version for Mongo API. Possible values are: 3.2 , 3.6 or 4.0"
#   default     = "4.0"
# }
variable "tags" {
  type = map(string)
}
variable "consistency_level" {
  type = string
  description = "Consistency level. Possible values are: BoundedStaleness, Eventual, Session, Strong or ConsistentPrefix"
  default     = "BoundedStaleness"
}
variable "max_interval_in_seconds" {
  type = number
  description = "When used with the Bounded Staleness consistency level, this value represents the time amount of staleness (in seconds) tolerated. Accepted range for this value is 5 - 86400"
  default     = "5"
}
variable "max_staleness_prefix" {
  type = number
  description = "When used with the Bounded Staleness consistency level, this value represents the number of stale requests tolerated. Accepted range for this value is 10 – 2147483647"
  default     = "100"
}
variable "interval_in_minutes" {
  type = number
  description = "Backup interval in minutes for CosmosDB.Possible values are between 60 and 1440"
}
variable "retention_in_hours" {
  type = number
  description = "Backup retention in hours for CosmosDB.Possible values are between 8 and 720"
}
variable "dbname" {
  type = string
  description = "Mongo DB Name"
}
variable "collection_name" {
  type = string
  description = "Mongo DB Collection Name"
}
variable "default_ttl_seconds" {
  type = number
  description = "TTL in seconds for DB collection. (Example 777)"
}
variable "shard_key" {
  type = string
  description = "The name of the key to partition on for sharding. There must not be any other unique index keys (example: UniqueKey)"
}

variable "throughput" {
  type = number
  description = " The throughput of the MongoDB collection (RU/s). Must be set in increments of 100. The minimum value is 400. This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply."
  default = 400
}

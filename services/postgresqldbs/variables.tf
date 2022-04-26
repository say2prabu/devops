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

variable "backend_suffix" {
  type = list(string)
}

variable "shared_suffix" {
  type = list(string)
}

variable "rsg_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
}

variable "postgresql_server_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default = {
    "AtosManaged" = "true"
  }
}

variable "postgresql_databases" {
  type        = map(map(string))
  description = "Map of maps containing config for the databases e.g. postgresql_databases = { testdb1={ database_charset = 'UTF8', database_collation = 'en-US' }, testdb2 = { database_charset = 'UTF8' database_collation = 'en-US' }}"
}

variable "storage_mb" {
  type        = number
  description = "The max storage allowed for the PostgreSQL Flexible Server. Possible values are 32768, 65536, 131072, 262144, 524288, 1048576, 2097152, 4194304, 8388608, 16777216, and 33554432"
  default     = null
}

variable "sku_name" {
  type        = string
  description = "Specifies the SKU Name for this PostgreSQL Server. The name of the SKU, follows the tier + family + cores pattern (e.g. B_Gen4_1, GP_Gen5_8)"
}

variable "deployment_mode_flexible" {
  type        = bool
  description = ""
  default     = false
}

variable "auto_grow_enabled" {
  type        = bool
  description = "Enable/Disable auto-growing of the storage. Storage auto-grow prevents your server from running out of storage and becoming read-only. If storage auto grow is enabled, the storage automatically grows without impacting the workload. The default value if not explicitly specified is true"
  default     = true
}
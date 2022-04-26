variable "name" {
  type        = string
  description = "The name of the PostgreSQL Server. This needs to be globally unique within Azure."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the PostgreSQL Server."
}

variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists."
}

variable "administrator_login" {
  type        = string
  description = "The administrator login name for the new server."
  default     = "sqladministrator"
}

variable "administrator_login_password" {
  type        = string
  description = "The password associated with the administrator_login user."
  default     = ""
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}

variable "postgresql_version" {
  type        = string
  description = "Specifies the version of PostgreSQL to use. Valid values are 9.5, 9.6, 10, 10.0, and 11. Changing this forces a new resource to be created."
  default     = "11"
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

variable "backup_retention_days" {
  type        = number
  description = "Backup retention days for the server, supported values are between 7 and 35 days"
  default     = 7
}

variable "geo_redundant_backup_enabled" {
  type        = bool
  description = "Turn Geo-redundant server backups on/off. This allows you to choose between locally redundant or geo-redundant backup storage in the General Purpose and Memory Optimized tiers. This option is only available for single server deployment mode"
  default     = null
}

variable "auto_grow_enabled" {
  type        = bool
  description = "Enable/Disable auto-growing of the storage. Storage auto-grow prevents your server from running out of storage and becoming read-only. If storage auto grow is enabled, the storage automatically grows without impacting the workload. The default value if not explicitly specified is true"
  default     = true
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Whether or not public network access is allowed for this server."
  default     = false
}

variable "ssl_enforcement_enabled" {
  type        = bool
  description = "Specifies if SSL should be enforced on connections."
  default     = true
}

variable "ssl_minimal_tls_version_enforced" {
  type        = string
  description = "The mimimun TLS version to support on the sever. Possible values are TLSEnforcementDisabled, TLS1_0, TLS1_1, and TLS1_2."
  default     = "TLS1_2"
}

variable "postgresql_databases" {
  type        = map(map(string))
  description = "Map of maps containing config for the databases e.g. postgresql_databases = { testdb1={ database_charset = 'UTF8', database_collation = 'en-US' }, testdb2 = { database_charset = 'UTF8' database_collation = 'en-US' }}"
}

variable "deployment_mode_flexible" {
  type        = bool
  description = ""
  default     = false
}

variable "delegated_subnet_id" {
  description = "value"
  default     = null
}

variable "private_dns_zone_id" {
  description = "value"
  default     = null
}
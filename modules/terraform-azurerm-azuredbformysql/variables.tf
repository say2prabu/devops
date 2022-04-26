variable "name" {
  type        = string
  description = "The name of the MySQL Server. This needs to be globally unique within Azure."
}
variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the MySQL Server."
}
variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists."
}
variable "mysql_version" {
  type        = string
  description = "The version for the new server. Valid values are: 5.7 and 8.0."
  default     = "8.0"
}
variable "sku_name" {
  type        = string
  description = "Specifies the name of the SKU used by the database. For example, B_Gen5_2, ElasticPool, Basic, S0, P2 ,DW100c, DS100."
  #default     = "B_Gen4_1"
}
variable "db_storage" {
  type        = number
  description = "The max size of the database in megabytes."
  default     = 5120
}
variable "administrator_login" {
  type        = string
  description = "The administrator login name for the new server."
  default     = "sqladministrator"
  sensitive   = true
}
variable "administrator_login_password" {
  type        = string
  description = "The password associated with the administrator_login user."
  default     = "koLNPhjsCQs87J?"
  sensitive   = true
}
variable "public_network_access_enabled" {
  type        = bool
  description = "Whether public network access is allowed for this server. Defaults to false."
  default     = true
}
variable "ssl_enforcement_enabled" {
  type        = bool
  description = "Whether SSL is enforced for this server. Defaults to true."
  default     = true
}
variable "ssl_minimal_tls_version_enforced" {
  type        = string
  description = "Minimal TLS Version"
  default     = "TLS1_2"
}
variable "backup_retention_days" {
  type        = number
  description = "Point In Time Restore configuration. Value has to be between 7 and 35."
  default     = 7
}
variable "geo_redundant_backup_enabled" {
  type        = bool
  description = "Turn Geo-redundant server backups on/off. This allows you to choose between locally redundant or geo-redundant backup storage in the General Purpose and Memory Optimized tiers. When the backups are stored in geo-redundant backup storage, they are not only stored within the region in which your server is hosted, but are also replicated to a paired data center. This provides better protection and ability to restore your server in a different region in the event of a disaster. This is not supported for the Basic tier."
}
variable "mysql_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
}
variable "database_name" {
  type        = string
  description = "The name of the MySQL Database."
}
variable "charset" {
  type        = string
  description = "Specifies the charset of the database"
  default     = "utf8"
}
variable "collation" {
  type        = string
  description = "Specifies the collation of the database"
  default     = "utf8_unicode_ci"
}
variable "ipv4_firewall_rule" {
  description = "nested mode: NestingList, min items: 0, max items: 0"
  type = map(object(
    {
      name        = string
      range_end   = string
      range_start = string
    }
  ))
  default = {}
}




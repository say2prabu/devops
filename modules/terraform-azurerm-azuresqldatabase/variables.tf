variable "name" {
  type        = string
  description = "The name of the Microsoft SQL Server. This needs to be globally unique within Azure."
}
variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the Microsoft SQL Server."
}
variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists."
}
variable "mssql_version" {
  type        = string
  description = "The version for the new server. Valid values are: 2.0 (for v11 server) and 12.0 (for v12 server)."
  default     = "12.0"
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
variable "minimum_tls_version" {
  type        = string
  description = "The Minimum TLS Version for all SQL Database and SQL Data Warehouse databases associated with the server. Valid values are: 1.0, 1.1 and 1.2."
  default     = "1.2"
}
variable "connection_policy" {
  type        = string
  description = "The connection policy the server will use. Possible values are Default, Proxy, and Redirect. Defaults to Default."
  default     = "Default"
}
variable "public_network_access_enabled" {
  type        = bool
  description = "Whether public network access is allowed for this server. Defaults to true."
  default     = false
}
variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default = {"Atos Managed"="True"} 
}
variable "mssql_db_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default = {"Atos Managed"="True"} 
}
# variable "database_name" {
#   type        = string
#   description = "The name of the MS SQL Database."
# }
variable "name_mssql" {
  type        = string
  description = "The name of the MS SQL Database "
}
variable "collation" {
  type        = string
  description = "Specifies the collation of the database"
  default     = "SQL_Latin1_General_CP1_CI_AS"
}
variable "license_type" {
  type        = string
  description = "Specifies the license type applied to this database. Possible values are LicenseIncluded and BasePrice."
  default     = "BasePrice"
}
variable "max_size_gb" {
  type        = number
  description = "The max size of the database in gigabytes."
  default     = 8
}
variable "sku_name" {
  type        = string
  description = "Specifies the name of the SKU used by the database. For example, GP_S_Gen5_2,HS_Gen4_1,BC_Gen5_2, ElasticPool, Basic, S0, P2 ,DW100c, DS100."
  default     = "BC_Gen5_2"
}
variable "zone_redundant" {
  type        = bool
  description = "Whether or not this database is zone redundant, which means the replicas of this database will be spread across multiple availability zones. This property is only settable for Premium and Business Critical databases."
#  default     = false
}
variable "storage_account_type" {
  type        = string
  description = "Specifies the storage account type used to store backups for this database. Possible values are GRS, LRS and ZRS. The default value is GRS."
#  default     = "GRS"
}
variable "retention_days" {
  type        = number
  description = "Point In Time Restore configuration. Value has to be between 7 and 35."
  default     = 7
}
variable "weekly_retention" {
  type        = string
  description = "The weekly retention policy for an LTR backup in an ISO 8601 format. Valid value is between 1 to 520 weeks. e.g. P1Y, P1M, P1W or P7D"
  default     = "P1Y"
}
variable "monthly_retention" {
  type        = string
  description = "The monthly retention policy for an LTR backup in an ISO 8601 format. Valid value is between 1 to 120 months. e.g. P1Y, P1M, P4W or P30D."
  default     = "P1Y"
}
variable "yearly_retention" {
  type        = string
  description = "The yearly retention policy for an LTR backup in an ISO 8601 format. Valid value is between 1 to 10 years. e.g. P1Y, P12M, P52W or P365D."
  default     = "P1Y"
}
variable "week_of_year" {
  type        = number
  description = "The week of year to take the yearly backup in an ISO 8601 format. Value has to be between 1 and 52."
  default     = 52
}
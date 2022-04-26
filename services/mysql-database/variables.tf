variable "azure_region" {
  type = string
  description = "The Azure location/region to which the resources are being deployed. This will be used to get the corresponding four character Atos code according to Atos DCS naming convention."
}
 variable "organization-code" {
  type = string
  description = "A three character Atos code according to Atos DCS naming convention indicating which organization we are deploying this automation for. When for Atos use: ats"
}
 variable "environment-code" {
  type = string
  description = "A one character Atos code according to Atos DCS naming convention to indicate which environment type will be deployed to. Example 'd' for Development, 't' for Test etc."
}
 variable "subscription-code" {
  type = string
  description = "A four character Atos code according to Atos DCS naming convention to indicate which subscription we are deploying the automation to. Example 'mgmt' for management, 'lnd1' for the 1st landingzone."
}


variable "mysql_server_resource_group_name" {
  type = string
  description = ""
}
variable "mysql_server_location" {
  type = string
  description = ""
}
variable "mysql_server_version" {
  type = string
  description = ""
  default = "8.0"
}
variable "mysql_server_sku_name" {
  type = string
  description = ""
  default = "GP_Gen5_2"
}
 variable "mysql_server_storage_mb" {
   type = number
   description = ""
default = 5120
 }
# variable "mysql_server_enabled" {
#   type = bool
#   description = ""
#   default = true
# }
# variable "mysql_server_version_enforced" {
#   type = string
#   description = ""
# }
variable "geo_redundant_backup_enabled"{
type = bool
description = "Turn Geo-redundant server backups on/off. This allows you to choose between locally redundant or geo-redundant backup storage in the General Purpose and Memory Optimized tiers. When the backups are stored in geo-redundant backup storage, they are not only stored within the region in which your server is hosted, but are also replicated to a paired data center. This provides better protection and ability to restore your server in a different region in the event of a disaster. This is not supported for the Basic tier." 
}
variable "mysql_tags" {
  type = map(string)
  description = "A mapping of tags to assign to the resource."
}
variable "database_name" {
  type = string
  description = ""
}

variable "charset" {
  type = string
  description = ""
  default = "utf8"
}

# variable "resource_group_name" {
#   type = string
#   description = ""
# }
# variable "mysql_db_collation" {
#   type = string
#   description = ""
# }

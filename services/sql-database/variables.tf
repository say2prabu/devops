variable "azure_region" {
  type        = string
  description = "The Azure location/region to which the resources are being deployed. This will be used to get the corresponding four character Atos code according to Atos DCS naming convention."
}
variable "organization-code" {
  type        = string
  description = "A three character Atos code according to Atos DCS naming convention indicating which organization we are deploying this automation for. When for Atos use: ats"
}
variable "environment-code" {
  type        = string
  description = "A one character Atos code according to Atos DCS naming convention to indicate which environment type will be deployed to. Example 'd' for Development, 't' for Test etc."
}
variable "subscription-code" {
  type        = string
  description = "A four character Atos code according to Atos DCS naming convention to indicate which subscription we are deploying the automation to. Example 'mgmt' for management, 'lnd1' for the 1st landingzone."
}

# variable "name" {
#   type = string
# }
variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the Microsoft SQL Server."
}
variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists."
}

variable "name_mssql" {
  type = string
  #  default = ["example","1",]
}
# variable "server_id" {
#   type = string
# }
# variable "collation" {
#   type = string
# }
# variable "license_type" {
#   type = string
# }
# variable "max_size_gb" {
#   type = string
# }
# variable "sku_name" {
#   type = string
# }
variable "zone_redundant" {
  type = string
}
variable "storage_account_type" {
  type = string
}
variable "tags" {
  type = map(string)
  default = {
    "Atosmanaged" = "true"
  }
}
variable "mssql_db_tags" {
  type = map(string)
  default = {
    "Atosmanaged" = "true"
  }
}
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
variable "vnet_name" {
  type = string
}
variable "vnet_rsgname" {
  type = string
}
variable "data_subnet_name" {
  type = string
}
variable "rsg_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
}
variable "dns_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
}
variable "dns_zone_names" {
  type = map(object({
    name     = string
  }))
  description = "The name(s) of the Private DNS Zone."
}
variable "mssql_db_names" {
  type = set(string)
}
variable "mssql_server_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default = {
    "AtosManaged"      = "true"
  }
}
variable "mssql_db_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default = {
    "AtosManaged"      = "true"
  }
}
variable "mssqlserver_subresources_name" {
  type    = list(string)
  default = ["sqlServer"]
}

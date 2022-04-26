variable "appinsights_name" {
  type        = string
  description = "Specifies the name of the app insights"
}
variable "tags" {
  type = map(string)
}
variable "resource_group_name" {
  type        = string
  description = "Specifies the name of the resource group"
}
variable "location" {
  type        = string
  description = "Specifies the name of the resource location"
}
variable "application_insights_type" {
  type        = string
  description = "specifies application insights type"
}
variable "retention_in_days" {
  type        = number
  description = "specifies the number of days for logs retention"
}
variable "disable_ip_masking" {
  type        = bool
  description = "enable of disable ip masking"
}

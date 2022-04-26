variable "appservice_name" {
  type        = string
  description = "specifies the name of the app service"
}
variable "tags" {
  type        = map(string)
  description = "specifies list of tags to be applied"
}
variable "resource_group_name" {
  type        = string
  description = "specifies name of the resource group"
}
variable "location" {
  type        = string
  description = "specifies name of the location"
}
variable "app_service_plan_id" {
  type        = string
  description = "specifies the app service plan id"
}
variable "site_config" {
  type        = any
  description = "Site configuration for Application Service"
  default     = {}
}
variable "enable_client_affinity" {
  type        = bool
  description = "Should the App Service send session affinity cookies, which route client requests in the same session to the same instance?"
  default     = false
}
variable "enable_client_certificate" {
  type        = bool
  description = "Does the App Service require client certificates for incoming requests"
  default     = false
}
variable "enable_https" {
  type        = bool
  description = "Can the App Service only be accessed via HTTPS?"
  default     = true
}
variable "connection_strings" {
  type        = list(map(string))
  description = "Connection strings for App Service"
  default     = []
}
variable "enable_appservice_vnet_integration" {
  type = bool
  description = "Does the app service require vnet integration or not"
  default = false
}
variable "subnet_id" {
  type        = string
  description = "The ID of the Subnet from which Private IP Addresses will be allocated."
}

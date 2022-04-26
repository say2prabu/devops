variable "function_app_name" {
  type        = string
  description = "specifies the name of the function app"
}

variable "resource_group_name" {
  type        = string
  description = "specifies resource group name for function app"
}
variable "location" {
  type        = string
  description = "specifies location for the function app"
}
variable "app_service_plan_id" {
  type        = string
  description = "specifies the app service plan id"
}

variable "tags" {
  type        = map(string)
  description = "specifies list of tags to be applied"
}

variable "storage_account_name" {
  type        = string
  description = "specifies the storage account name for function app"
}

variable "storage_account_access_key" {
  type        = string
  description = "specifies the storage account access key"
}

variable "enable_https" {
  type        = bool
  description = "Can the App Service only be accessed via HTTPS?"
  default     = true
}

variable "site_config" {
  type        = any
  description = "Site configuration for Application Service"
  default     = {}
}

variable "subnet_id" {
  type        = string
  description = "The ID of the Subnet from which Private IP Addresses will be allocated."
}

variable "connection_strings" {
  type        = list(map(string))
  description = "Connection strings for App Service"
  default     = []
}

variable "application_insights_enabled" {
  type        = bool
  description = "Can the App Insights enabled"
  default     = false

}

variable "application_insights_id" {
  type        = string
  description = "The ID of the Subnet from which Private IP Addresses will be allocated."
  default     = null

}

variable "app_settings" {
  type        = any
  description = "app settings for function app"
  default     = {}
}
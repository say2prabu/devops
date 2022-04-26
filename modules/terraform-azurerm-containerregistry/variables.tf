variable "name" {
  type        = string
  description = "The name of the ACR instance. This needs to be globally unique within Azure."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the ACR instance."
}

variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}

variable "sku" {
  type        = string
  description = "The SKU name of the container registry. Possible values are Basic, Standard and Premium. Classic (which was previously Basic) is supported only for existing resources."
  default     = "Basic"
}

variable "georeplication_locations" {
  type        = list(string)
  description = "(Optional) A list of Azure locations where the container registry should be geo-replicated."
  default     = []
}

variable "admin_enabled" {
  description = "(Optional) Specifies whether the admin user is enabled. Defaults to false."
  type        = string
  default     = false
}

variable "public_network_access_enabled" {
  description = "(Optional) Whether public network access is allowed for the container registry. Defaults to true."
  type        = bool
  default     = true
}
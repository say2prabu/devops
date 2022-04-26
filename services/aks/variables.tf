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

variable "backend_suffix_aks" {
  type = string
  default = "pool1"
}

variable "backend_suffix_acr" {
  type = string
  default = "acr1"
}

variable "shared_suffix" {
  type = string
  default = "shared"
}

# variable "rsg_tags" {
#   type        = map(string)
#   description = "A mapping of tags to assign to the resource."
#   default = {
#     "AtosManaged" = "true"
#   }
# }

variable "aks_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default = {
    "AtosManaged" = "true"
  }
}

variable "acr_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default = {
    "AtosManaged" = "true"
  }
}

variable "acr_sku" {
  type        = string
  description = "The SKU name of the container registry. Possible values are Basic, Standard and Premium. Classic (which was previously Basic) is supported only for existing resources."
  default     = "Basic"
}

variable "tenant_id" {
  description = "(Required) The tenant id of the system assigned identity which is used by master components."
  type        = string
}

variable "admin_group_object_ids" {
  description = "(Optional) A list of Object IDs of Azure Active Directory Groups which should have Admin Role on the Cluster."
  default     = []
  type        = list(string)
}

variable "dns_prefix" {
  description = "(Optional) DNS prefix specified when creating the managed cluster. Changing this forces a new resource to be created."
  type        = string
  default = "cluster1"
}

variable "resource_group_name" {
  type = string
  description = "resource group name"
}

# variable "resource_group_location" {
#   type = string
#   description = "resource group location"
# }
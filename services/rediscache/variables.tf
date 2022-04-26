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

variable "rsg_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
}

variable "sku_name" {
  type        = string
  description = "The SKU of Redis to use. Possible values are Basic, Standard and Premium."
}

variable "family" {
  type        = map(string)
  description = "The SKU family/pricing group to use. Valid values are C (for Basic/Standard SKU family) and P (for Premium)."

  default = {
    Basic    = "C"
    Standard = "C"
    Premium  = "P"
  }
}

variable "capacity" {
  type        = number
  description = "The size of the Redis cache to deploy. Valid values for a SKU family of C (Basic/Standard) are 0, 1, 2, 3, 4, 5, 6, and for P (Premium) family are 1, 2, 3, 4."
}
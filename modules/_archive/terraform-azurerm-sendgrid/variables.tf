variable "sendgrid_name" {
  type = string
}

variable "deployment_mode" {
  type    = string
  default = "Incremental"
}

variable "resource_group_name" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "azureSubscriptionId" {
  type = string
}

variable "sendgrid_properties" {
  type = object({
    quantity  = number
    autoRenew = bool
    planId    = string
    offerId   = string
    termId    = string
  })

}
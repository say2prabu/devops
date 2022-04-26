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

# variable "backend_suffix" {
#   type = list(string)
# }
variable "lb_private_ip" {
  type = set(object(
    {
      name                          = string
      subnet_id                     = string
      private_ip_address            = string
      private_ip_address_allocation = string
    }
  ))
  #type = any
}
variable "backend_pool" {
  type        = any
  description = "A map of Backend pool configurations"
}
variable "backend_pool_address" {
  type        = any
  description = "A map of backend pool addresses"
}
variable "lb_probe" {
  type        = any
  description = "A map of load balancer probe configurations"
}
variable "lb_rule" {
  type        = any
  description = "A map of load balancer rule configurations"
}
variable "lb_nat_rule" {
  type        = any
  description = "A map of NAT rules configurations"
}
variable "sku" {
  type        = string
  description = "SKU for LoadBalancer. Accepted values are Basic, Standard and Gateway"
}
variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default = {
    "Atosmanaged" = "True"
  }
}
# variable "rsg_tags" {
#   type        = map(string)
#   description = "A mapping of tags to assign to the resource."
#   default = {
#     "Atosmanaged" = "True"
#   }
# }


variable "resource_group_name"{
  type = string
}
variable "location"{
  type = string
}
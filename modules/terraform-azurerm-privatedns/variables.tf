variable "dns_zone_name" {
  type = map(object({
    name     = string
  }))
  description = "The name(s) of the Private DNS Zone."
}
variable "resource_group_name" {
  type        = string
  description = "Specifies the resource group where the resource exists."
}
variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
}
variable "virtual_network_id" {
  type        = string
  description = "The ID of the Virtual Network that should be linked to the DNS Zone. Changing this forces a new resource to be created."
}
variable "registration_enabled" {
  type        = bool
  description = "Is auto-registration of virtual machine records in the virtual network in the Private DNS zone enabled?"
  default     = false
}

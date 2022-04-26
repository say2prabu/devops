variable "name" {
  type = string
  description = "Specifies the Name of the Private Endpoint."
}
variable "location" {
  type        = string
  description = "The supported Azure location where the resource exists."
}
variable "resource_group_name" {
  type        = string
  description = "Specifies the Name of the Resource Group within which the Private Endpoint should exist."
}
variable "subnet_id" {
  type        = string
  description = "The ID of the Subnet from which Private IP Addresses will be allocated for this Private Endpoint."
}
variable "private_service_connection_name" {
  type = string
  description = "Specifies the Name of the Private Service Connection."
}
variable "is_manual_connection" {
  type        = bool
  description = "Does the Private Endpoint require Manual Approval from the remote resource owner?"
  default = false
}
variable "private_connection_resource_id" {
  type        = string
  description = "The ID of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to."
}
variable "subresources_name" {
  type        = list(string)
  description = "A list of subresource names which the Private Endpoint is able to connect to. subresource_names corresponds to group_id."
}

variable "private_dns_zone_group_name" {
  type = string
  description = "Specifies the Name of the Private DNS Zone Group."
}

variable "private_dns_zone_ids" {
  type = list(string)
  description = "Specifies the list of Private DNS Zones to include within the private_dns_zone_group."
}

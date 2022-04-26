variable "datafactory_name" {
  type        = string
  description = "Specifies the name of the Resource Group."
}
variable "resource_group_name" {
  type        = string
  description = "specifies name of the resource group"
}
variable "location" {
  type        = string
  description = "Specifies the location of the Resource Group."
}
variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
}
variable "adf_ir_name" {
  type        = set(string)
  description = "The name of the IR"
  default     = []
}

variable "adf_linked_services_sftp" {
  default = {}
}

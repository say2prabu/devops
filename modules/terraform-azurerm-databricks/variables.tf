variable "databricks_name" {
  type = string
  description = "Specifies the name of the data bricks resource."
}

variable "resource_group_name" {
  type        = string
  description = "specifies name of the resource group for the data bricks resource"
}
variable "location" {
  type = string
  description = "Specifies the location for the data bricks resource."
}
variable "tags" {
  type = map(string)
  description = "A mapping of tags to assign to the resource."
}

variable "sku" {
  type = string
  description = "Specifies the sku for Databricks"
  
}

variable "managed_databricks_rg_name" {
  type = string
  description = "Specifies the name of the managed databrick resource group name"
}

variable "databricks_storage_account_name" {
  type = string
  description = "Specifies the name of the managed databrick resource group name"  
}

variable "virtual_network_id" {
  type = string
  description = "Specifies the id of the virtual network"   
}
variable "public_subnet_name" {
  type = string
  description = "Specifies the name of the public subnet" 
}

variable "private_subnet_name" {
  type = string
  description = "Specifies the name of private subnet" 
}

variable "public_subnet_network_security_group_association_id" {
  type = string
  description = "Specifies the id of nsg for public subnet" 
}

variable "private_subnet_network_security_group_association_id" {
  type = string
  description = "Specifies the id of the nsg for private subnet" 
}
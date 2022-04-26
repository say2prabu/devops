variable "name" {
  type        = string
  description = "The name of the SQL Managed Instance. This needs to be globally unique within Azure."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the SQL Server."
}

variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists."
}

variable "administrator_login" {
  type        = string
  description = "The administrator login name for the new server."
  default     = "admSiemensFMEA"
  sensitive   = true
}

variable "administrator_login_password" {
  type        = string
  description = "The password associated with the administrator_login user"
  sensitive   = true
}

variable "license_type" {
  type        = string
  description = "What type of license the Managed Instance will use. Valid values include can be PriceIncluded or BasePrice."
  default     = "BasePrice"
}

variable "subnet_id" {
  type        = string
  description = "The subnet resource id that the SQL Managed Instance will be associated with."
}

variable "sku_name" {
  type        = string
  description = "Specifies the SKU Name for the SQL Managed Instance. Valid values include GP_Gen4, GP_Gen5, BC_Gen4, BC_Gen5."
}

variable "vcores" {
  type        = number
  description = "Number of cores that should be assigned to your instance. Values can be 8, 16, or 24 if sku_name is GP_Gen4, or 8, 16, 24, 32, or 40 if sku_name is GP_Gen5."
  default     = 4
}

variable "storage_size_in_gb" {
  type        = number
  description = "Maximum storage space for your instance. It should be a multiple of 32GB."
  default     = 32
}

variable "collation" {
  type        = string
  description = "Specifies how the SQL Managed Instance will be collated. Default value is SQL_Latin1_General_CP1_CI_AS."
}

variable "timezone_id" {
  type        = string
  description = "The TimeZone ID that the SQL Managed Instance will be operating in. Default value is UTC."
}

variable "proxy_override" {
  type        = string
  description = "Specifies how the SQL Managed Instance will be accessed. Default value is Default. Valid values include Default, Proxy, and Redirect."
  default     = "Redirect"
}
variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
}

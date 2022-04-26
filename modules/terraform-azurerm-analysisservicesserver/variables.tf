variable "name" {
  type        = string
  description = "Specifies the name of the storage account"
}
variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the storage account."
}
variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists."
}
variable "admin_users" {
  description = "List of email addresses or Security Groups of admin users"
  type        = set(string)
}

variable "backup_blob_container_uri" {
  description = "URI and SAS token for a blob container to store backups"
  type        = string
}

variable "enable_power_bi_service" {
  description = "True/False. Indicates if the Power BI service is allowed to access or not"
  type        = bool
}

variable "querypool_connection_mode" {
  description = "Controls how the read-write server is used in the query pool. If this value is set to All then read-write servers are also used for queries. Otherwise with ReadOnly these servers do not participate in query operations"
  type        = string
}
variable "sku" {
  description = "SKU for the Analysis Services Server. Possible values are: D1, B1, B2, S0, S1, S2, S4, S8, S9, S8v2 and S9v2."
  type        = string
}
variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
}

variable "ipv4_firewall_rule" {
  description = "nested mode: NestingList, min items: 0, max items: 0"
  type = set(object(
    {
      name        = string
      range_end   = string
      range_start = string
    }
  ))
  default = []
}


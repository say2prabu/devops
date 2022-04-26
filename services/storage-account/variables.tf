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

variable "vnet_name" {
  type = string
}
variable "vnet_rsgname" {
  type = string
}
variable "data_subnet_name" {
  type = string
}
variable "rsg_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
}
variable "dns_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
}
variable "sa_account_kind" {
  type    = string
  default = "StorageV2"
}
variable "sa_account_tier" {
  type    = string
  default = "Standard"
}
variable "sa_account_replication_type" {
  type    = string
  default = "ZRS"
}
variable "sa_access_tier" {
  type    = string
  default = "Hot"
}
variable "sa_allow_blob_public_access" {
  type    = bool
  default = false
}
variable "sa_shared_access_key_enabled" {
  type    = bool
  default = true
}
variable "sa_change_feed_enabled" {
    type = bool
}
variable "sa_versioning_enabled" {
    type = bool
}
variable "sa1_is_hns_enabled" {
  type = bool
}
variable "sa2_is_hns_enabled" {
  type = bool
}
variable "sa_blob_delete_retention_policy" {
  type = number
}
variable "sa_container_delete_retention_policy" {
  type = number
}
variable "sa_bypass" {
  type    = list(string)
  default = ["AzureServices", "Logging", "Metrics"]
}
variable "sa_default_action" {
  type    = string
  default = "Deny"
}
variable "sa_ip_rules" {
  type = list(any)
}
variable "sa1_container_names" {
  type = set(string)
}
variable "sa2_container_names" {
  type = set(string)
}
variable "sa_container_access_type" {
  type    = string
  default = "private"
}
variable "sa1_share_names" {
  type = set(string)
  default = []
}
variable "sa2_share_names" {
  type = set(string)
  default = []
}
variable "sa_share_quota" {
  type = number
}
variable "sa2_queue_names" {
  type = set(string)
  default = []
}
variable "sa1_table_names" {
  type = set(string)
  default = []
}
variable "sa2_table_names" {
  type = set(string)
  default = []
}
variable "sa_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default = {
    "AtosManaged"      = "true"
    "AtosMonitoringID" = "value"
  }
}
variable "sa_subresources_name" {
  type    = list(string)
  default = ["blob"]
}
variable "dns_zone_names" {
  type = map(object({
    name     = string
  }))
}


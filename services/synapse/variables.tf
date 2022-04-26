variable "azure_region" {
  type = string
}
variable "organization_code" {
  type = string
}
variable "environment_code" {
  type = string
}
variable "subscription_code_lnd2" {
  type = string
}
variable "subscription_code_cnty" {
  type = string
}
variable "datalake_suffix" {
  type = list(string)
}
variable "blob_suffix" {
  type = list(string)
}
variable "shared_suffix" {
  type = list(string)
}
variable "synapse_suffix" {
  type = list(string)
}
variable "vnet_name" {
  type = string
}
variable "vnet_resource_group_name" {
  type = string
}
variable "data_subnet_name" {
  type = string
}
variable "resource_group_tags" {
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
variable "dl_is_hns_enabled" {
  type = bool
}
variable "blob_is_hns_enabled" {
  type = bool
}
variable "sa_ip_rules" {
  type = list(any)
}
variable "dl_container_names" {
  type = set(string)
}
variable "blob_container_names" {
  type = set(string)
}
variable "sa_subresources_name" {
  type    = list(string)
  default = ["blob"]
}

variable "synapse_sql_subresources_name" {
  type    = list(string)
  default = ["Sql"]
}
variable "synapse_dev_subresources_name" {
  type    = list(string)
  default = ["Dev"]
}
variable "synapse_sqlod_subresources_name" {
  type    = list(string)
  default = ["SqlOnDemand"]
}
variable "synapse_web_subresources_name" {
  type    = list(string)
  default = ["Web"]
}
variable "synapse_fs" {
  type = string
}
variable "sa_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
}
variable "synapse_workspace_name" {
  type = string
}
variable "synapse_managed_virtual_network_enabled" {
  type = bool
}
variable "synapse_data_exfiltration_protection_enabled" {
  type = bool
}
variable "synapse_workspace_tags" {
  type = map(string)
}
variable "dns_zone_names" {
  type = map(object({
    name = string
  }))
}
variable "dns_tags" {
  type = map(string)
}
variable "synapse_sql_pools" {
  description = "SQL Pools. Provide the SQL Pool name, the SKU Name for this Synapse Sql Pool and how to create SQL Pool"
  type = map(object({
    sku_name    = string
    collation   = string
    create_mode = string
    tags        = map(string)
  }))
}

variable "synapse_spark_pools" {
  description = "Spark Pools. Provide the Spark Pool name, node information, spark version & autoscaling details (min & max node counts)."
  type = map(object({
    node_size_family = string
    node_size        = string
    spark_version    = string
    min_node_count   = number
    max_node_count   = number
    delay_in_minutes = number
    tags             = map(string)
  }))
}

variable "synapse_firewall_rules" {
  description = "Firewall rules. Provide the firewall rule name and the range of the ip addresses (start & end ip address)."
  type = map(object({
    start_ip_address = string
    end_ip_address   = string
  }))
}
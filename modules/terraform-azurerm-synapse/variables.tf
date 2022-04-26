variable "workspace_name" {
  type        = string
  description = "Specifies the name which should be used for this synapse Workspace."
}
variable "resource_group_name" {
  type        = string
  description = "Specifies the name of the Resource Group where the synapse Workspace should exist."
}
variable "location" {
  type        = string
  description = "Specifies the Azure Region where the synapse Workspace should exist"
}
variable "storage_data_lake_gen2_filesystem_id" {
  type        = string
  description = "Specifies the ID of storage data lake gen2 filesystem resource."
}
variable "sql_administrator_login" {
  type        = string
  description = "Specifies The Login Name of the SQL administrator"
  default     = "sqladministrator"
}
variable "sql_administrator_login_password" {
  type        = string
  description = "The Password associated with the sql_administrator_login for the SQL administrator."
  default     = "koLNPhjsCQs87J?"
}
variable "managed_virtual_network_enabled" {
  type        = bool
  description = "Is Virtual Network enabled for all computes in this workspace?"
}
variable "data_exfiltration_protection_enabled" {
  type        = bool
  description = "Is data exfiltration protection enabled in this workspace? If set to true, managed_virtual_network_enabled must also be set to true"
}
variable "workspace_tags" {
  type        = map(string)
  description = "A mapping of tags which should be assigned to the resource."
}
variable "synapse_private_link_hub_name" {
  type        = string
  description = "The name which should be used for this Synapse Private Link Hub."
}
variable "sql_pools" {
  description = "SQL Pools. Provide the SQL Pool name, the SKU Name for this Synapse Sql Pool and how to create SQL Pool"
  type = map(object({
    sku_name    = string
    collation   = string
    create_mode = string
    tags        = map(string)
  }))
}
//"pool name"   - The name of the SQL pool. The key value of each map object is used as the pool name.
//"sku_name"    - Specifies the SKU Name for this Synapse Sql Pool. Possible values are DW100c, DW200c, DW300c, DW400c, DW500c, DW1000c, DW1500c, DW2000c, DW2500c, DW3000c, DW5000c, DW6000c, DW7500c, DW10000c, DW15000c or DW30000c.
//"collation"   - The name of the collation to use with this pool, only applicable when create_mode is set to Default." Default: SQL_LATIN1_GENERAL_CP1_CI_AS
//"create_mode" - Specifies how to create the Sql Pool. Valid values are: Default, Recovery or PointInTimeRestore. Must be Default to create a new database."

variable "spark_pools" {
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
//"pool name"        - The name of the Spark pool. The key value of each map object is used as the pool name.
//"node_size_family" - The kind of nodes that the Spark Pool provides. Possible value is MemoryOptimized.
//"node_size"        - The level of node in the Spark Pool. Possible value is Small, Medium and Large
//"spark_version"    - The Apache Spark version. Possible values are 2.4 and 3.1. Defaults to 2.4
//"min_node_count" & "max_node_count" - The minimum number of nodes the Spark Pool can support. Must be between 3 and 200.
//"delay_in_minutes" - Number of minutes of idle time before the Spark Pool is automatically paused. Must be between 5 and 10080.

variable "firewall_rules" {
  description = "Firewall rules. Provide the firewall rule name and the range of the ip addresses (start & end ip address)."
  type = map(object({
    start_ip_address = string
    end_ip_address   = string
  }))
}
//"firewall rule name" - The name of the firewall rule. The key value of each map object is used as the firewall rule name.
//"start_ip_address"   - The starting IP address to allow through the firewall for this rule.
//"end_ip_address"     - The level of node in the Spark Pool. Possible value is Small, Medium and Large
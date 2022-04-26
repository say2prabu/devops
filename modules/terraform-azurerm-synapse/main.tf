resource "azurerm_synapse_workspace" "synapse_workspace" {
  name                                 = var.workspace_name
  resource_group_name                  = var.resource_group_name
  location                             = var.location
  storage_data_lake_gen2_filesystem_id = var.storage_data_lake_gen2_filesystem_id
  sql_administrator_login              = var.sql_administrator_login
  sql_administrator_login_password     = var.sql_administrator_login_password
  managed_virtual_network_enabled      = var.managed_virtual_network_enabled
  data_exfiltration_protection_enabled = var.data_exfiltration_protection_enabled
  tags                                 = var.workspace_tags
}

resource "azurerm_synapse_private_link_hub" "synapse_private_link_hub" {
  name                = var.synapse_private_link_hub_name
  resource_group_name = var.resource_group_name
  location            = var.location
}

resource "azurerm_synapse_sql_pool" "synapse_sql_pool" {
  for_each = var.sql_pools

  name                 = each.key
  synapse_workspace_id = azurerm_synapse_workspace.synapse_workspace.id
  sku_name             = each.value.sku_name
  create_mode          = each.value.create_mode
  collation            = each.value.create_mode != "Default" ? each.value.collation : null
  tags                 = each.value.tags

  depends_on = [azurerm_synapse_workspace.synapse_workspace]
}

resource "azurerm_synapse_spark_pool" "synapse_spark_pool" {
  for_each = var.spark_pools

  name                 = each.key
  synapse_workspace_id = azurerm_synapse_workspace.synapse_workspace.id
  node_size_family     = each.value.node_size_family
  node_size            = each.value.node_size
  spark_version        = each.value.spark_version

  auto_scale {
    min_node_count = each.value.min_node_count
    max_node_count = each.value.max_node_count
  }
  auto_pause {
    delay_in_minutes = each.value.delay_in_minutes
  }
  tags = each.value.tags

  depends_on = [azurerm_synapse_workspace.synapse_workspace]
}

resource "azurerm_synapse_firewall_rule" "synapse_firewall_rule" {
  for_each = var.firewall_rules

  name                 = each.key
  synapse_workspace_id = azurerm_synapse_workspace.synapse_workspace.id
  start_ip_address     = each.value.start_ip_address
  end_ip_address       = each.value.end_ip_address

  depends_on = [azurerm_synapse_sql_pool.synapse_sql_pool]
}

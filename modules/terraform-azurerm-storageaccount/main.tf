resource "azurerm_storage_account" "sa" {
  name                      = var.name
  resource_group_name       = var.resource_group_name
  location                  = var.location
  account_kind              = var.account_kind
  account_tier              = var.account_tier
  account_replication_type  = var.account_replication_type
  access_tier               = var.access_tier
  enable_https_traffic_only = var.enable_https_traffic_only
  allow_blob_public_access  = var.allow_blob_public_access
  shared_access_key_enabled = var.shared_access_key_enabled
  min_tls_version           = var.min_tls_version
  is_hns_enabled            = var.is_hns_enabled

  dynamic "blob_properties" {
    for_each = var.is_hns_enabled ? [1] : []
    content {}
  }
  dynamic "blob_properties" {
    for_each = var.is_hns_enabled ? [] : [1]
    content {
      change_feed_enabled = var.change_feed_enabled
      versioning_enabled  = var.versioning_enabled
      delete_retention_policy {
        days = var.blob_delete_retention_policy
      }
      container_delete_retention_policy {
        days = var.container_delete_retention_policy
      }
    }
  }
  tags = var.tags
}
resource "azurerm_storage_container" "sacontainer" {
  for_each              = var.container_name
  name                  = each.value
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = var.container_access_type
}
resource "azurerm_storage_share" "sashare" {
  for_each             = var.share_name
  name                 = each.value
  storage_account_name = azurerm_storage_account.sa.name
  quota                = var.share_quota
}
resource "azurerm_storage_queue" "saqueue" {
  for_each             = var.queue_name
  name                 = each.value
  storage_account_name = azurerm_storage_account.sa.name
}
resource "azurerm_storage_table" "satable" {
  for_each             = var.table_name
  name                 = each.value
  storage_account_name = azurerm_storage_account.sa.name
}

resource "azurerm_storage_account_network_rules" "sanetworkrules" {
  storage_account_id = azurerm_storage_account.sa.id
  default_action     = var.default_action
  ip_rules           = var.ip_rules
  bypass             = var.bypass
}



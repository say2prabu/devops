module "sa1_naming" {
  source = "../../modules/terraform-naming"

  azure_region      = var.azure_region
  organization-code = var.organization_code
  environment-code  = var.environment_code
  subscription-code = var.subscription_code
  suffix            = var.backend_suffix
}
module "sa2_naming" {
  source = "../../modules/terraform-naming"

  azure_region      = var.azure_region
  organization-code = var.organization_code
  environment-code  = var.environment_code
  subscription-code = var.subscription_code
  suffix            = var.shared_suffix
}

data "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.vnet_rsgname
}
data "azurerm_subnet" "data_subnet" {
  name                 = var.data_subnet_name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_virtual_network.vnet.resource_group_name
}

module "shared_resourcegroup" {
  source = "../../modules/terraform-azurerm-resourcegroup"

  name     = module.sa1_naming.resource_group.name
  location = module.sa1_naming.azure_region
  tags     = var.rsg_tags
}
module "privatelink_dnszones" {
  source = "../../modules/terraform-azurerm-privatedns"

  dns_zone_name       = var.dns_zone_names
  resource_group_name = module.shared_resourcegroup.resource_group_name
  tags                = var.dns_tags
  virtual_network_id  = data.azurerm_virtual_network.vnet.id
}

module "storage1_account" {
  source = "../../modules/terraform-azurerm-storageaccount"

  name                              = module.sa1_naming.storage_account.name_unique
  resource_group_name               = module.shared_resourcegroup.resource_group_name
  location                          = module.shared_resourcegroup.resource_group_location
  account_replication_type          = var.sa_account_replication_type
  is_hns_enabled                    = var.sa1_is_hns_enabled
  versioning_enabled                = var.sa_versioning_enabled
  change_feed_enabled               = var.sa_change_feed_enabled
  account_tier                      = var.sa_account_tier
  account_kind                      = var.sa_account_kind
  blob_delete_retention_policy      = var.sa_blob_delete_retention_policy
  container_delete_retention_policy = var.sa_container_delete_retention_policy
  container_name                    = var.sa1_container_names
  share_name                        = var.sa1_share_names
  share_quota                       = var.sa_share_quota
  table_name                        = var.sa1_table_names
  default_action                    = var.sa_default_action
  ip_rules                          = var.sa_ip_rules
  bypass                            = var.sa_bypass
  tags                              = var.sa_tags
}
module "afqp_sa_privateendpoint" {
  source = "../../modules/terraform-azurerm-privateendpoint"

  name                        = module.sa1_naming.private_endpoint.name_unique
  resource_group_name         = module.shared_resourcegroup.resource_group_name
  location                    = module.shared_resourcegroup.resource_group_location
  subnet_id                   = data.azurerm_subnet.data_subnet.id
  private_dns_zone_group_name = module.sa1_naming.private_dns_zone_group_name.name_unique
  private_dns_zone_ids        = [module.privatelink_dnszones.private_dns["blob"].id]

  private_service_connection_name = module.sa1_naming.private_service_connection.name_unique
  private_connection_resource_id  = module.storage1_account.sa_id
  subresources_name               = var.sa_subresources_name
}

module "storage2_account" {
  source = "../../modules/terraform-azurerm-storageaccount"

  name                              = module.sa2_naming.storage_account.name_unique
  resource_group_name               = module.shared_resourcegroup.resource_group_name
  location                          = module.shared_resourcegroup.resource_group_location
  account_replication_type          = var.sa_account_replication_type
  is_hns_enabled                    = var.sa2_is_hns_enabled
  versioning_enabled                = var.sa_versioning_enabled
  change_feed_enabled               = var.sa_change_feed_enabled
  account_tier                      = var.sa_account_tier
  account_kind                      = var.sa_account_kind
  blob_delete_retention_policy      = var.sa_blob_delete_retention_policy
  container_delete_retention_policy = var.sa_container_delete_retention_policy
  container_name                    = var.sa2_container_names
  default_action                    = var.sa_default_action
  ip_rules                          = var.sa_ip_rules
  bypass                            = var.sa_bypass
  tags                              = var.sa_tags
}
module "sa2_privateendpoint" {
  source = "../../modules/terraform-azurerm-privateendpoint"

  name                        = module.sa2_naming.private_endpoint.name_unique
  resource_group_name         = module.shared_resourcegroup.resource_group_name
  location                    = module.shared_resourcegroup.resource_group_location
  subnet_id                   = data.azurerm_subnet.data_subnet.id
  private_dns_zone_group_name = module.sa2_naming.private_dns_zone_group_name.name_unique
  private_dns_zone_ids        = [module.privatelink_dnszones.private_dns["blob"].id]

  private_service_connection_name = module.sa2_naming.private_service_connection.name_unique
  private_connection_resource_id  = module.storage2_account.sa_id
  subresources_name               = var.sa_subresources_name
}


module "datalake_naming" {
  source = "../../modules/terraform-naming"

  azure_region      = var.azure_region
  organization-code = var.organization_code
  environment-code  = var.environment_code
  subscription-code = var.subscription_code_lnd2
  suffix            = var.datalake_suffix
}
module "blob_naming" {
  source = "../../modules/terraform-naming"

  azure_region      = var.azure_region
  organization-code = var.organization_code
  environment-code  = var.environment_code
  subscription-code = var.subscription_code_lnd2
  suffix            = var.blob_suffix
}
module "shared_naming" {
  source = "../../modules/terraform-naming"

  azure_region      = var.azure_region
  organization-code = var.organization_code
  environment-code  = var.environment_code
  subscription-code = var.subscription_code_lnd2
  suffix            = var.shared_suffix
}
module "synapse_naming" {
  source = "../../modules/terraform-naming"

  azure_region      = var.azure_region
  organization-code = var.organization_code
  environment-code  = var.environment_code
  subscription-code = var.subscription_code_lnd2
  suffix            = var.synapse_suffix
}
module "synapse_web_naming" {
  source = "../../modules/terraform-naming"

  azure_region      = var.azure_region
  organization-code = var.organization_code
  environment-code  = var.environment_code
  subscription-code = var.subscription_code_lnd2
  suffix            = var.shared_suffix
}
module "synapse_sql_naming" {
  source = "../../modules/terraform-naming"

  azure_region      = var.azure_region
  organization-code = var.organization_code
  environment-code  = var.environment_code
  subscription-code = var.subscription_code_lnd2
  suffix            = var.shared_suffix
}
module "synapse_sqlod_naming" {
  source = "../../modules/terraform-naming"

  azure_region      = var.azure_region
  organization-code = var.organization_code
  environment-code  = var.environment_code
  subscription-code = var.subscription_code_lnd2
  suffix            = var.shared_suffix
}

module "synapse_dev_naming" {
  source = "../../modules/terraform-naming"

  azure_region      = var.azure_region
  organization-code = var.organization_code
  environment-code  = var.environment_code
  subscription-code = var.subscription_code_lnd2
  suffix            = var.shared_suffix
}

data "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.vnet_resource_group_name
}
data "azurerm_subnet" "data_subnet" {
  name                 = var.data_subnet_name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_virtual_network.vnet.resource_group_name
}
module "datalake_resourcegroup" {
  source = "../../modules/terraform-azurerm-resourcegroup"

  name     = module.datalake_naming.resource_group.name
  location = module.datalake_naming.azure_region
  tags     = var.resource_group_tags
}

module "blob_resourcegroup" {
  source = "../../modules/terraform-azurerm-resourcegroup"

  name     = module.blob_naming.resource_group.name
  location = module.blob_naming.azure_region
  tags     = var.resource_group_tags
}

module "shared_resourcegroup" {
  source = "../../modules/terraform-azurerm-resourcegroup"

  name     = module.shared_naming.resource_group.name
  location = module.shared_naming.azure_region
  tags     = var.resource_group_tags
}

module "privatelink_dnszones" {
  source = "../../modules/terraform-azurerm-privatedns"

  dns_zone_name       = var.dns_zone_names
  resource_group_name = module.shared_resourcegroup.resource_group_name
  tags                = var.dns_tags
  virtual_network_id  = data.azurerm_virtual_network.vnet.id
}

module "datalake_storage_account" {
  source = "../../modules/terraform-azurerm-storageaccount"

  name                              = module.datalake_naming.storage_account.name_unique
  resource_group_name               = module.datalake_resourcegroup.resource_group_name
  location                          = module.datalake_resourcegroup.resource_group_location
  account_replication_type          = var.sa_account_replication_type
  is_hns_enabled                    = var.dl_is_hns_enabled
  versioning_enabled                = var.sa_versioning_enabled
  change_feed_enabled               = var.sa_change_feed_enabled
  account_tier                      = var.sa_account_tier
  account_kind                      = var.sa_account_kind
  blob_delete_retention_policy      = var.sa_blob_delete_retention_policy
  container_delete_retention_policy = var.sa_container_delete_retention_policy
  container_name                    = var.dl_container_names
  default_action                    = var.sa_default_action
  ip_rules                          = var.sa_ip_rules
  bypass                            = var.sa_bypass
  tags                              = var.sa_tags
}

module "datalake_privateendpoint" {
  source = "../../modules/terraform-azurerm-privateendpoint"

  name                        = module.datalake_naming.private_endpoint.name_unique
  resource_group_name         = module.datalake_resourcegroup.resource_group_name
  location                    = module.datalake_resourcegroup.resource_group_location
  subnet_id                   = data.azurerm_subnet.data_subnet.id
  private_dns_zone_group_name = module.datalake_naming.private_dns_zone_group_name.name_unique
  private_dns_zone_ids        = [module.privatelink_dnszones.private_dns["blob"].id]

  private_service_connection_name = module.datalake_naming.private_service_connection.name_unique
  private_connection_resource_id  = module.datalake_storage_account.sa_id
  subresources_name               = var.sa_subresources_name
}

module "blob_storage_account" {
  source = "../../modules/terraform-azurerm-storageaccount"

  name                              = module.blob_naming.storage_account.name_unique
  resource_group_name               = module.blob_resourcegroup.resource_group_name
  location                          = module.blob_resourcegroup.resource_group_location
  account_replication_type          = var.sa_account_replication_type
  is_hns_enabled                    = var.blob_is_hns_enabled
  versioning_enabled                = var.sa_versioning_enabled
  change_feed_enabled               = var.sa_change_feed_enabled
  account_tier                      = var.sa_account_tier
  account_kind                      = var.sa_account_kind
  blob_delete_retention_policy      = var.sa_blob_delete_retention_policy
  container_delete_retention_policy = var.sa_container_delete_retention_policy
  container_name                    = var.blob_container_names
  default_action                    = var.sa_default_action
  ip_rules                          = var.sa_ip_rules
  bypass                            = var.sa_bypass
  tags                              = var.sa_tags
}

module "blob_privateendpoint" {
  source = "../../modules/terraform-azurerm-privateendpoint"

  name                        = module.blob_naming.private_endpoint.name_unique
  resource_group_name         = module.blob_resourcegroup.resource_group_name
  location                    = module.blob_resourcegroup.resource_group_location
  subnet_id                   = data.azurerm_subnet.data_subnet.id
  private_dns_zone_group_name = module.blob_naming.private_dns_zone_group_name.name_unique
  private_dns_zone_ids        = [module.privatelink_dnszones.private_dns["blob"].id]

  private_service_connection_name = module.blob_naming.private_service_connection.name_unique
  private_connection_resource_id  = module.blob_storage_account.sa_id
  subresources_name               = var.sa_subresources_name
}

module "synapse_resources" {
  source = "../../modules/terraform-azurerm-synapse"

  workspace_name                       = var.synapse_workspace_name
  resource_group_name                  = module.datalake_resourcegroup.resource_group_name
  location                             = module.datalake_resourcegroup.resource_group_location
  storage_data_lake_gen2_filesystem_id = "https://${module.datalake_storage_account.sa_name}.dfs.core.windows.net/${var.synapse_fs}"
  managed_virtual_network_enabled      = var.synapse_managed_virtual_network_enabled
  data_exfiltration_protection_enabled = var.synapse_data_exfiltration_protection_enabled
  workspace_tags                       = var.synapse_workspace_tags

  synapse_private_link_hub_name = module.datalake_naming.private_link_hub.name_unique

  sql_pools      = var.synapse_sql_pools
  spark_pools    = var.synapse_spark_pools
  firewall_rules = var.synapse_firewall_rules

  depends_on = [module.datalake_storage_account]
}

module "blob_managed_privateendpoint" {
  source = "../../modules/terraform-azurerm-synapse-managed-private-endpoint"

  name                 = module.synapse_naming.managed_private_endpoint.name_unique
  synapse_workspace_id = module.synapse_resources.workspace_id
  target_resource_id   = module.blob_storage_account.sa_id
  subresource_name     = var.sa_subresources_name[0]

  depends_on = [
    module.synapse_resources
  ]
}

module "datalake_managed_privateendpoint" {
  source = "../../modules/terraform-azurerm-synapse-managed-private-endpoint"

  name                 = module.datalake_naming.managed_private_endpoint.name_unique
  synapse_workspace_id = module.synapse_resources.workspace_id
  target_resource_id   = module.datalake_storage_account.sa_id
  subresource_name     = var.sa_subresources_name[0]

  depends_on = [
    module.synapse_resources
  ]
}

module "synapse_web_privateendpoint" {
  source = "../../modules/terraform-azurerm-privateendpoint"

  name                        = module.synapse_web_naming.private_endpoint.name_unique
  resource_group_name         = module.datalake_resourcegroup.resource_group_name
  location                    = module.datalake_resourcegroup.resource_group_location
  subnet_id                   = data.azurerm_subnet.data_subnet.id
  private_dns_zone_group_name = module.synapse_web_naming.private_dns_zone_group_name.name_unique
  private_dns_zone_ids        = [module.privatelink_dnszones.private_dns["synapseweb"].id]

  private_service_connection_name = module.synapse_web_naming.private_service_connection.name_unique
  private_connection_resource_id  = module.synapse_resources.privatelink_hub_id
  subresources_name               = var.synapse_web_subresources_name
}

module "synapse_sql_privateendpoint" {
  source = "../../modules/terraform-azurerm-privateendpoint"

  name                        = module.synapse_sql_naming.private_endpoint.name_unique
  resource_group_name         = module.datalake_resourcegroup.resource_group_name
  location                    = module.datalake_resourcegroup.resource_group_location
  subnet_id                   = data.azurerm_subnet.data_subnet.id
  private_dns_zone_group_name = module.synapse_sql_naming.private_dns_zone_group_name.name_unique
  private_dns_zone_ids        = [module.privatelink_dnszones.private_dns["synapsesql"].id]

  private_service_connection_name = module.synapse_sql_naming.private_service_connection.name_unique
  private_connection_resource_id  = module.synapse_resources.workspace_id
  subresources_name               = var.synapse_sql_subresources_name
}

module "synapse_sqlod_privateendpoint" {
  source = "../../modules/terraform-azurerm-privateendpoint"

  name                        = module.synapse_sqlod_naming.private_endpoint.name_unique
  resource_group_name         = module.datalake_resourcegroup.resource_group_name
  location                    = module.datalake_resourcegroup.resource_group_location
  subnet_id                   = data.azurerm_subnet.data_subnet.id
  private_dns_zone_group_name = module.synapse_sqlod_naming.private_dns_zone_group_name.name_unique
  private_dns_zone_ids        = [module.privatelink_dnszones.private_dns["synapsesql"].id]

  private_service_connection_name = module.synapse_sqlod_naming.private_service_connection.name_unique
  private_connection_resource_id  = module.synapse_resources.workspace_id
  subresources_name               = var.synapse_sqlod_subresources_name
}

module "synapse_dev_privateendpoint" {
  source = "../../modules/terraform-azurerm-privateendpoint"

  name                        = module.synapse_dev_naming.private_endpoint.name_unique
  resource_group_name         = module.datalake_resourcegroup.resource_group_name
  location                    = module.datalake_resourcegroup.resource_group_location
  subnet_id                   = data.azurerm_subnet.data_subnet.id
  private_dns_zone_group_name = module.synapse_dev_naming.private_dns_zone_group_name.name_unique
  private_dns_zone_ids        = [module.privatelink_dnszones.private_dns["synapsedev"].id]

  private_service_connection_name = module.synapse_dev_naming.private_service_connection.name_unique
  private_connection_resource_id  = module.synapse_resources.workspace_id
  subresources_name               = var.synapse_dev_subresources_name
}

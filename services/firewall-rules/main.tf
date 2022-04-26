# module "naming_fw" {
#   source = "../../modules/terraform-naming"
#   azure_region      = var.azure_region
#   organization-code = var.organization_code
#   environment-code  = var.environment_code
#   subscription-code = var.subscription_code
# }

# module "resource_group_fw_rule" {
#   source    = "../../modules/terraform-azurerm-resourcegroup"
#   name      = module.naming_fw.resource_group.name
#   location  = var.azure_region
#   tags      = var.tags
# }

resource "azurerm_firewall_policy" "test_policy" {
  name                = "test-policy"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  sku                 = "Premium"
}


module "firewall_rules" {
    source = "../../modules/terraform-azurerm-firewall-rules"
    firewall_policy_rule_collection_group_name  = var.firewall_policy_rule_collection_group_name
    firewall_policy_id                          = azurerm_firewall_policy.test_policy.id
    collection_group_priority                   = var.collection_group_priority

    app_rule_collection_name                    = var.app_rule_collection_name
    app_rule_collection_priority                = var.app_rule_collection_priority
    app_rule_collection_action                  = var.app_rule_collection_action
    app_rules                                   = var.app_rules
    app_collection                              = var.app_collection

    nat_rule_collection_name                    = var.nat_rule_collection_name
    nat_rule_collection_priority                = var.nat_rule_collection_priority
    nat_rule_collection_action                  = var.nat_rule_collection_action
    nat_rules                                   = var.nat_rules
    nat_collection                              = var.nat_collection

    network_rule_collection_name                = var.network_rule_collection_name
    network_rule_collection_priority            = var.network_rule_collection_priority
    network_rule_collection_action              = var.network_rule_collection_action
    network_rules                               = var.network_rules
    network_collection                          = var.network_collection
}

# firewall_policy_rule_collection_group_name:
# firewall_policy_id:
# collection_group_priority:
# app_rule_collection:
#     collection1:
#         name:
#         priority:
#         action:
#         rule:
#             rule1:
#                 name:
#                 description:
#                 source_addresses:
#                 source_ip_groups:
#                 destination_fqdn_tags:
#                 destination_addresses:
#                 destination_fqdns:
#                 terminate_tls:
#                 web_categories:
#                 protocol:
#                     port:
#                     type:
resource "azurerm_firewall_policy_rule_collection_group" "firewall_rule_collection" {
    name               = var.firewall_policy_rule_collection_group_name
    firewall_policy_id = var.firewall_policy_id
    priority           = var.collection_group_priority
    dynamic "application_rule_collection"{
        for_each = var.app_collection
        content{
        name                = var.app_rule_collection_name
        priority            = var.app_rule_collection_priority
        action              = var.app_rule_collection_action

        dynamic "rule"{
        for_each = var.app_rules
            content {
            name                    = lookup(rule.value , "name" , "")
            #description             = lookup(rule.value , "description" , "")
            source_addresses        = lookup(rule.value , "source_addresses" , [""])
            #source_ip_groups        = lookup(rule.value , "source_ip_groups" , [""])
            destination_fqdn_tags   = lookup(rule.value , "destination_fqdn_tags" , [""])
            #destination_urls        = lookup(rule.value , "destination_urls" , [""]) #conflicts with destination fqdns - need premium urls
            #destination_addresses   = lookup(rule.value , "destination_addresses" , [""])
            #destination_fqdns       = lookup(rule.value , "destination_fqdns" , [""]) # conflicts with destination urls
            #terminate_tls           = lookup(rule.value , "terminate_tls" , false) # premium only and must be true when using destination urls
            #web_categories          = lookup(rule.value , "web_categories" , [""]) # web categrories needs premium.
            dynamic "protocols"{
                for_each = rule.value["protocols"] #protocols required when specifying destination_fqdns.  not required when specifying fqdn tags
                content{
                port = lookup(protocols.value , "port" , "")
                type = lookup(protocols.value , "type" , "")
                }
            }
            }
        }
        }
    }
        # dynamic "rule"{
        #     for_each = var.app_rules
        #     content{
        #     name                    = lookup(rule.value , "name" , "")
        #     description             = lookup(rule.value , "description" , "")
        #     source_addresses        = lookup(rule.value , "source_addresses" , [""])
        #     source_ip_groups        = lookup(rule.value , "source_ip_groups" , [""])
        #     destination_fqdn_tags   = lookup(rule.value , "destination_fqdn_tags" , [""])
        #     destination_urls        = lookup(rule.value , "destination_urls" , [""])
        #     #protocols required when specifying destination_fqdns.
        #     destination_addresses   = lookup(rule.value , "destination_addresses" , [""])
        #     destination_fqdns       = lookup(rule.value , "destination_fqdns" , [""])
        #     terminate_tls           = lookup(rule.value , "terminate_tls" , false)
        #     web_categories          = lookup(rule.value , "web_categories" , [""])
        #     dynamic "protocol" {
        #         for_each = rule.value["protocol"]
        #         port = lookup(protocol.value , "port" , "")
        #         type = lookup(protocol.value , "type" , "")
        #     }
        #     }
        

    
    dynamic "nat_rule_collection" {
        for_each = var.nat_collection
        content{
        name                = var.nat_rule_collection_name
        priority            = var.nat_rule_collection_priority
        action              = var.nat_rule_collection_action
        
        dynamic "rule" {
        for_each = var.nat_rules
        content {
            name                  = lookup(rule.value , "name" , "")
            #description           = lookup(rule.value , "description" , "")
            destination_address   = lookup(rule.value , "destination_address" , [""])
            destination_ports     = lookup(rule.value , "destination_ports" , [""])
            protocols             = lookup(rule.value , "protocols" , [""])
            source_addresses      = lookup(rule.value , "source_addresses" , [""])
            source_ip_groups      = lookup(rule.value , "source_ip_groups" , [""])
            translated_address    = lookup(rule.value , "translated_address" , "")#only one of translated address and translated fqdn should be set
            translated_port       = lookup(rule.value , "translated_port" , "")
            #translated_fqdn       = lookup(rule.value , "translated_fqdn" , "")#only one of translated address and translated fqdn should be set
            
            }
        }
        }

    }
    dynamic "network_rule_collection" {
        for_each = var.network_collection
        content{
        name                = var.network_rule_collection_name
        priority            = var.network_rule_collection_priority
        action              = var.network_rule_collection_action
        
        dynamic "rule" {
        for_each = var.network_rules
        content{
            name                  = lookup(rule.value , "name" , "") #var.network_rule_rule_name
            #description           = lookup(rule.value , "description" , "")#var.network_rule_rule_description
            source_addresses      = lookup(rule.value , "source_addresses" , [""])##var.network_rule_rule_source_addresses
            source_ip_groups      = lookup(rule.value , "source_ip_groups" , [""])#var.network_rule_rule_source_ip_groups
            destination_addresses = lookup(rule.value , "destination_addresses" , [""])#var.network_rule_rule_destination_addresses
            destination_ip_groups = lookup(rule.value , "destination_ip_groups" , [""])#var.network_rule_rule_destination_ip_groups
            destination_fqdns     = lookup(rule.value , "destination_fqdns" , [""])#var.dns_proxy_enabled?  var.network_rule_rule_destination_fqdns : null
            destination_ports     = lookup(rule.value , "destination_ports" , [""])#var.network_rule_rule_destination_ports
            protocols             = lookup(rule.value , "protocols" , [""])#var.network_rule_rule_protocol  
            }
        }
        }
    }
}












# resource "azurerm_firewall_application_rule_collection" "az_firewall_application_allow_rule_collection" {
#   #for_each = [  ]
#   name                = var.app_allow_rule_name
#   azure_firewall_name = var.firewall_name
#   resource_group_name = var.resource_group_name
#   priority            = var.app_allow_rule_priority
#   action              = "Allow"

#   dynamic "rule" {
#     for_each = var.app_allow_rules
#     content {
#     name                = lookup(rule.value , "name" , "")
#     description         = lookup(rule.value , "description" , "")
#     source_addresses    = lookup(rule.value , "source_addresses" , [""])
#     source_ip_groups    = lookup(rule.value , "source_ip_groups" , [""])
#     fqdn_tags           = lookup(rule.value , "fqdn_tags" , [""])
#     target_fqdns        = lookup(rule.value , "target_fqdns" , [""])
#     protocol {
#       port = lookup(rule.value , "port" , "")
#       type = lookup(rule.value , "type" , "")
#     }
#   }
#   }
# }
# # #At least one of source_addresses and source_ip_groups must be specified for a rule.
# resource "azurerm_firewall_application_rule_collection" "az_firewall_application_deny_rule_collection" {
#   name                = var.app_deny_rule_name
#   azure_firewall_name = var.firewall_name
#   resource_group_name = var.resource_group_name
#   priority            = var.app_deny_rule_priority
#   action              = "Deny"

#   dynamic "rule" {
#     for_each = var.app_deny_rules
#     content {
#     name                = lookup(rule.value , "name" , "")
#     description         = lookup(rule.value , "description" , "")
#     source_addresses    = lookup(rule.value , "source_addresses" , [""])
#     source_ip_groups    = lookup(rule.value , "source_ip_groups" , [""])
#     fqdn_tags           = lookup(rule.value , "fqdn_tags" , [""])
#     target_fqdns        = lookup(rule.value , "target_fqdns" , [""])
#     protocol {
#       port = lookup(rule.value , "port" , "")
#       type = lookup(rule.value , "type" , "")
#     }
#   }
#   }
# }



# resource "azurerm_firewall_nat_rule_collection" "az_firewall_nat_rule_collection_dnat" {
#   name                = var.nat_DNAT_rule_name
#   azure_firewall_name = var.nat_DNAT_rule_name != null ? azurerm_firewall.az_firewall.name: ""
#   resource_group_name = var.nat_DNAT_rule_name != null ? azurerm_firewall.az_firewall.resource_group_name : ""
#   priority            = var.nat_DNAT_rule_priority
#   action              = "Dnat"

#   dynamic "rule" {
#     for_each = var.DNAT_rules
#     content {
#     name                  = lookup(rule.value , "name" , "")
#     description           = lookup(rule.value , "description" , "")
#     destination_addresses = lookup(rule.value , "destination_addresses" , [""])
#     destination_ports     = lookup(rule.value , "destination_ports" , [""])
#     protocols             = lookup(rule.value , "protocols" , [""])
#     source_addresses      = lookup(rule.value , "source_addresses" , [""])
#     source_ip_groups      = lookup(rule.value , "source_ip_groups" , [""])
#     translated_address    = lookup(rule.value , "translated_address" , "")
#     translated_port       = lookup(rule.value , "translated_port" , "")
#     }
#   }
# depends_on = [
#   azurerm_firewall.az_firewall
# ]
# }
# resource "azurerm_firewall_nat_rule_collection" "az_firewall_nat_rule_collection_snat" {
#   name                = var.nat_SNAT_rule_name
#   azure_firewall_name = var.nat_SNAT_rule_name != null ? azurerm_firewall.az_firewall.name: ""
#   resource_group_name = var.nat_SNAT_rule_name != null ? azurerm_firewall.az_firewall.resource_group_name : ""
#   priority            = var.nat_SNAT_rule_priority
#   action              = "Snat"

#   dynamic "rule" {
#     for_each = var.SNAT_rules
#     content {
#     name                  = lookup(rule.value , "name" , "")
#     description           = lookup(rule.value , "description" , "")
#     destination_addresses = lookup(rule.value , "destination_addresses" , "")
#     destination_ports     = lookup(rule.value , "destination_ports" , "")
#     protocols             = lookup(rule.value , "protocols" , "")
#     source_addresses      = lookup(rule.value , "source_addresses" , "")
#     source_ip_groups      = lookup(rule.value , "source_ip_groups" , "")
#     translated_address    = lookup(rule.value , "translated_address" , "")
#     translated_port       = lookup(rule.value , "translated_port" , "")
#     }
#   }
# }



# resource "azurerm_firewall_network_rule_collection" "az_firewall_network_rule_collection_allow" {
#   name                = var.network_allow_rule_name
#   azure_firewall_name = var.network_allow_rule_name != null ? azurerm_firewall.az_firewall.name: ""
#   resource_group_name = var.network_allow_rule_name != null ? azurerm_firewall.az_firewall.resource_group_name : ""
#   priority            = var.network_allow_rule_priority
#   action              = "Allow"

#   dynamic "rule" {
#     for_each = var.network_allow_rules
#     content{
#     name                  = lookup(rule.value , "name" , "") #var.network_rule_rule_name
#     description           = lookup(rule.value , "description" , "")#var.network_rule_rule_description
#     source_addresses      = lookup(rule.value , "source_addresses" , [""])##var.network_rule_rule_source_addresses
#     source_ip_groups      = lookup(rule.value , "source_ip_groups" , [""])#var.network_rule_rule_source_ip_groups
#     destination_addresses = lookup(rule.value , "destination_addresses" , [""])#var.network_rule_rule_destination_addresses
#     destination_ip_groups = lookup(rule.value , "destination_ip_groups" , [""])#var.network_rule_rule_destination_ip_groups
#     destination_fqdns     = lookup(rule.value , "destination_fqdns" , [""])#var.dns_proxy_enabled?  var.network_rule_rule_destination_fqdns : null
#     destination_ports     = lookup(rule.value , "destination_ports" , [""])#var.network_rule_rule_destination_ports
#     protocols             = lookup(rule.value , "protocols" , [""])#var.network_rule_rule_protocol  
#     }
#   }
#   depends_on = [
#   azurerm_firewall.az_firewall
# ]
# }
# resource "azurerm_firewall_network_rule_collection" "az_firewall_network_rule_collection_deny" {
#   name                = var.network_deny_rule_name
#   azure_firewall_name = var.network_deny_rule_name != null ? azurerm_firewall.az_firewall.name: ""
#   resource_group_name = var.network_deny_rule_name != null ? azurerm_firewall.az_firewall.resource_group_name : ""
#   priority            = var.network_deny_rule_priority
#   action              = "Deny"

#   dynamic "rule" {
#     for_each = var.network_deny_rules
#     content{
#     name                  = lookup(rule.value , "name" , "") #var.network_rule_rule_name
#     description           = lookup(rule.value , "description" , "")#var.network_rule_rule_description
#     source_addresses      = lookup(rule.value , "source_addresses" , [""])##var.network_rule_rule_source_addresses
#     source_ip_groups      = lookup(rule.value , "source_ip_groups" , [""])#var.network_rule_rule_source_ip_groups
#     destination_addresses = lookup(rule.value , "destination_addresses" , [""])#var.network_rule_rule_destination_addresses
#     destination_ip_groups = lookup(rule.value , "destination_ip_groups" , [""])#var.network_rule_rule_destination_ip_groups
#     destination_fqdns     = lookup(rule.value , "destination_fqdns" , [""])#var.dns_proxy_enabled?  var.network_rule_rule_destination_fqdns : null
#     destination_ports     = lookup(rule.value , "destination_ports" , [""])#var.network_rule_rule_destination_ports
#     protocols             = lookup(rule.value , "protocols" , [""])#var.network_rule_rule_protocol  
#     }
#   }
#   depends_on = [
#   azurerm_firewall.az_firewall
# ]
# }
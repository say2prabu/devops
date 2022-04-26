# variable "azure_region" {
#   type = string
# }

# variable "organization_code" {
#   type = string
# }

# variable "environment_code" {
#   type = string
# }

# variable "subscription_code" {
#   type = string
# }

variable "firewall_policy_rule_collection_group_name"{
    type = string
}
# variable "firewall_policy_id"{
#     type = string
# }
variable "collection_group_priority"{
    type = number
}

# variable "tags" {
#     type = map(string)
#     default = {
#       "AtosManaged" = "True"
#     }
  
# }

variable "app_rule_collection_name"{
    type = string
    description = "The name which should be used for this application rule collection."
    default = "value"
    #default = ""
}
variable "app_rule_collection_priority"{
    type = number
    description = "The priority of the application rule collection. The range is 100 - 65000."
    default = 100
    #default = null
}
variable "app_rule_collection_action"{
    type = string
    description = "The action to take for the application rules in this collection. Possible values are Allow and Deny."
    #default = "Allow"
    default = "Allow"
}
variable "app_rules"{
    type = any
    description = "collection of rules and their respective information blocks"
    default = {rule = {
        name                    = "allow-rule"
        #description             = lookup(rule.value , "description" , "")
        source_addresses        = ["10.0.0.1","10.0.0.3"]
        #source_ip_groups        = [" "]
        destination_fqdn_tags   = ["tags"]
        #destination_urls        = lookup(rule.value , "destination_urls" , [""]) #conflicts with destination fqdns - need premium urls
        #destination_addresses   = lookup(rule.value , "destination_addresses" , [""])
        #destination_fqdns       = [" "] # conflicts with destination urls
        #terminate_tls           = lookup(rule.value , "terminate_tls" , false) # premium only and must be true when using destination urls
        #web_categories          = lookup(rule.value , "web_categories" , [""]) # web categrories needs premium.
        protocols = {protocol = {
            port = 443
            type = "Https"
        },}
    },}
}
variable "app_collection" {
    type = any
    default = {}
}

variable "nat_rule_collection_name"{
    type = string
    description = "The name which should be used for this nat rule collection."
    default = ""
}
variable "nat_rule_collection_priority"{
    type = number
    description = "The priority of the nat rule collection. The range is 100 - 65000."
    default = null
}
variable "nat_rule_collection_action"{
    type = string
    description = "The action to take for the nat rules in this collection. Currently, the only possible value is Dnat."
    default = ""
}
variable "nat_rules"{
    type = any
    description = "collection of rules and their respective information blocks"
    default = []
}
variable "nat_collection" {
  type = any
  default = []
}

variable "network_rule_collection_name"{
    type = string
    description = "The name which should be used for this network rule collection."
    default = ""
}
variable "network_rule_collection_priority"{
    type = number
    description = "The priority of the network rule collection. The range is 100 - 65000."
    default = null
}
variable "network_rule_collection_action"{
    type = string
    description = "The action to take for the network rules in this collection. Possible values are Allow and Deny."
    default = ""
}
variable "network_rules"{
    type = any
    description = "collection of rules and their respective information blocks"
    default = []
}
variable "network_collection" {
  type = any
  default = []
}



variable "resource_group_name"{
    type = string
}
variable "resource_group_location"{
    type = string
}
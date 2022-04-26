variable "firewall_policy_rule_collection_group_name"{
    type = string
    description = "he name which should be used for this Firewall Policy Rule Collection Group. Changing this forces a new Firewall Policy Rule Collection Group to be created."
}
variable "firewall_policy_id"{
    type = string
    description = "The ID of the Firewall Policy where the Firewall Policy Rule Collection Group should exist. Changing this forces a new Firewall Policy Rule Collection Group to be created."
}
variable "collection_group_priority"{
    type = number
    description = "The priority of the Firewall Policy Rule Collection Group. The range is 100-65000."
}

# variable "app_rule_collection"{
#     type = any
# }
variable "app_rule_collection_name"{
    type = string
    description = "The name which should be used for this application rule collection."
}
variable "app_rule_collection_priority"{
    type = number
    description = "The priority of the application rule collection. The range is 100 - 65000."
}
variable "app_rule_collection_action"{
    type = string
    description = "The action to take for the application rules in this collection. Possible values are Allow and Deny."
}
variable "app_rules"{
    type = any
    description = "collection of rules and their respective information blocks"
}
variable "app_collection" {
  type = any
}

variable "nat_rule_collection_name"{
    type = string
    description = "The name which should be used for this nat rule collection."
}
variable "nat_rule_collection_priority"{
    type = number
    description = "The priority of the nat rule collection. The range is 100 - 65000."
}
variable "nat_rule_collection_action"{
    type = string
    description = "The action to take for the nat rules in this collection. Currently, the only possible value is Dnat."
}
variable "nat_rules"{
    type = any
    description = "collection of rules and their respective information blocks"
}
variable "nat_collection" {
  type = any
}


variable "network_rule_collection_name"{
    type = string
    description = "The name which should be used for this network rule collection."
}
variable "network_rule_collection_priority"{
    type = number
    description = "The priority of the network rule collection. The range is 100 - 65000."
}
variable "network_rule_collection_action"{
    type = string
    description = "The action to take for the network rules in this collection. Possible values are Allow and Deny."
}
variable "network_rules"{
    type = any
    description = "collection of rules and their respective information blocks"
}
variable "network_collection" {
  type = any
}
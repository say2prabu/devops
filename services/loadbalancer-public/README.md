# terraform-azurerm-loadbalancer-public
Terraform module to create a Public (external) Azure Load Balancer, and dynamically create Backend Pools, Rules, Health Probes and NAT Rules and Outbound Rules.

## Description
Azure Load Balancer is the single point of contact for clients and distributes inbound flows that arrives at the load balancer's front end to backend pool instances. These flows are according to configured rules and health probes.
A public load balancer can provide outbound connections for virtual machines (VMs) inside your virtual network. These connections are accomplished by translating their private IP addresses to public IP addresses. Public Load Balancers are used to load balance internet traffic to your VMs.

## Azure Load Balancer module usage

As this module can dynamically deploy Load Balancer properties (Backend Pools, Rules, Health Probes and NAT Rules, etc), in order to properly deploy the Azure Load Balancer module, the following things needs to be taken into consideration:

- The following variables were created as a map structure to declare the configuration for each property:
   - lb_pip
   - backend_pool         
   - backend_pool_address                 
   - lb_probe                    
   - lb_rule
   - lb_nat_rule
   - lb_outbound_rule

- The variables above are used in a for_each loop inside the keyvault module so you can declare as many elements as it is required by the use case (see usage example in the .tfvars example below)

NOTE: Global SKU Tier does not support NAT rules and Outbound rules. In that way, the variables lb_nat_rule and lb_outbound_rule still needs to be declared but the values for the variables needs to be empty. 

- "lb_pip" variable:
```hcl
 lb_pip = {
  tmppip1 = {
    allocation_method = "string"
    idle_timeout      = "number"
  }
}
}

```

- "backend_pool" variable:
```hcl
 backend_pool = {
  pool1 = {
  }
  pool2 = {
  }
}
This variable will declare the backend pool names

```
- "backend_pool_address" variable:
```hcl
backend_pool_address = {
  vm1 = {
    vnet_id           = "string"
    backend_ip        = "string"
    backend_pool_name = "string"
  }
}
```
- "lb_probe" variable:
```hcl
lb_probe = {
  probe1 = {
    port                = "number"
    protocol            = "string"
    interval_in_seconds = "number"
    number_of_probes    = "number"
  }
}
```
- "lb_rule" variable:

```hcl
lb_rule = {
  rule1 = {
    frontend_ip_name     = "string"
    lb_probe_name        = "string"
    lb_backend_pool_name = "string"
    protocol             = "string"
    frontend_port        = "number"
    backend_port         = "number"
    disable_snat         = "bool"
    enable_tcp_reset     = "bool"
    idle_timeout         = "number"
    enable_floating_ip   = "bool"
  }
}
```

  - "lb_nat_rule" variable:

  ```hcl
lb_nat_rule = {
  natrule1 = {
    frontend_ip_name               = "string"
    lb_nat_rule_protocol           = "string"
    lb_nat_rule_front_port         = "number"
    lb_nat_rule_back_port          = "number"
    lb_nat_rule_enable_floating_ip = "bool"
  }
}
 
```
  - "lb_outbound_rule" variable:

  ```hcl
lb_outbound_rule = {
  outrule1 = {
    lb_backend_pool_name             = "string"
    pip_name                         = [list of strings]
    lb_outbound_rule_protocol        = "string"
    lb_outbound_rule_allocated_ports = "number"
    lb_outbound_rule_idle_timeout    = "number"
  }
}
 
```

## Module Example Use
```hcl
module "loadbalancer" {
  source = "../../modules/terraform-azurerm-loadbalancer-public"

  name                 = module.loadbalancer_naming.loadbalancer.name
  location             = module.loadbalancer_resourcegroup.resource_group_location
  resource_group_name  = module.loadbalancer_resourcegroup.resource_group_name
  sku                  = var.sku
  tags                 = var.tags
  lb_pip               = var.lb_pip
  backend_pool         = var.backend_pool
  backend_pool_address = var.backend_pool_address
  lb_probe             = var.lb_probe
  lb_rule              = var.lb_rule
  lb_nat_rule          = var.lb_nat_rule
  lb_outbound_rule     = var.lb_outbound_rule
}


```

## Module Arguments

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `name` | `string` | true | Name of the Azure Load Balancer to be deployed. |
| `resource_group_name` | `string` | true | The name of the resource group in which to create the Azure Load Balancer. |
| `location` | `string` | true | Resource location. |
| `sku` | `string` | true | SKU for LoadBalancer. Accepted values are Basic, Standard and Gateway |
| `sku_tier` | `string` | true | SKU tier for LoadBalancer. Accepted values are Regional and Global |
| `lb_pip` | `map` | true | One ore more public frontend IP configuration blocks |
| `backend_pool` | `any` | true | One or more backend pool configuration blocks. See above detailed description |
| `backend_pool_address` | `any` | true | One ore more backend pool address configuration blocks. See above detailed description |
| `lb_probe` | `any` | true | One or more Load Balancer Health Probe confgiuration blocks. See above detailed description |
| `lb_rule` | `any` | true | One or more Load Balancer Rule confgiuration blocks. See above detailed description |
| `lb_nat_rule` | `any` | true | One or more Load Balancer NAT Rule confgiuration blocks. See above detailed description |
| `lb_outbound_rule` | `any` | true | One or more Load Balancer outbound Rule confgiuration blocks. See above detailed description |
| `tags` | `map` | false | A mapping of tags to assign to the resource. |

For a complete list of all the possible arguments (terraform variables), see the variables.tf file in this modules folder.
## Module outputs

| Name | Description | Value
| --- | --- | --- |
| `` |  | `` |

## Root Module usage

If needed, the Private Load Balancer child module can be called from a root module. Root module example usage:



Example .tfvars

```hcl
azure_region      = "westeurope"
organization_code = "lbr"
environment_code  = "t"
subscription_code = "lnd1"

backend_suffix = [
  "dev"
]

rsg_tags = {
  "AtosManaged" = "true"
}

sku     = "Standard"
sku_tier  = "Regional"
tags = {
  "AtosManaged" = "true"
  "Owner"       = "user1"
}
lb_pip = {
  tmppip1 = {
    allocation_method = "Static"
    idle_timeout      = "7"
  }
  tmppip2 = {
    allocation_method = "Static"
    idle_timeout      = "8"
  }
}


backend_pool = {
  pool1 = {
  }
  pool2 = {
  }
}
backend_pool_address = {
  vm1 = {
    vnet_id           = "/subscriptions/acb557ca-ad2e-4fbe-b32e-96464f10d0a6/resourceGroups/test-VMs/providers/Microsoft.Network/virtualNetworks/test-VMs-vnet"
    backend_ip        = "10.1.0.4"
    backend_pool_name = "pool1"
  }
  vm2 = {
    vnet_id           = "/subscriptions/acb557ca-ad2e-4fbe-b32e-96464f10d0a6/resourceGroups/test-VMs/providers/Microsoft.Network/virtualNetworks/test-VMs-vnet"
    backend_ip        = "10.1.0.5"
    backend_pool_name = "pool1"
  }
}
lb_probe = {
  probe1 = {
    port                = "22"
    protocol            = "Tcp"
    interval_in_seconds = "20"
    number_of_probes    = "3"
  }
  probe2 = {
    port                = "3389"
    protocol            = "Tcp"
    interval_in_seconds = "22"
    number_of_probes    = "4"
  }
}
lb_rule = {
  rule1 = {
    frontend_ip_name     = "tmppip1"
    lb_probe_name        = "probe1"
    lb_backend_pool_name = "pool1"
    protocol             = "Tcp"
    frontend_port        = "3389"
    backend_port         = "3389"
    disable_snat         = "true"
    enable_tcp_reset     = "true"
    idle_timeout         = "7"
    enable_floating_ip   = "false"
  }
  rule2 = {
    frontend_ip_name     = "tmppip1"
    lb_probe_name        = "probe2"
    lb_backend_pool_name = "pool1"
    protocol             = "Tcp"
    frontend_port        = "22"
    backend_port         = "22"
    disable_snat         = "true"
    enable_tcp_reset     = "true"
    idle_timeout         = "7"
    enable_floating_ip   = "false"
  }
}
lb_nat_rule = {
  natrule1 = {
    frontend_ip_name               = "tmppip1"
    lb_nat_rule_protocol           = "Tcp"
    lb_nat_rule_front_port         = "443"
    lb_nat_rule_back_port          = "443"
    lb_nat_rule_enable_floating_ip = "false"
  }
  natrule2 = {
    frontend_ip_name               = "tmppip2"
    lb_nat_rule_protocol           = "Tcp"
    lb_nat_rule_front_port         = "22"
    lb_nat_rule_back_port          = "22"
    lb_nat_rule_enable_floating_ip = "false"
  }
}
lb_outbound_rule = {
  outrule1 = {
    lb_backend_pool_name             = "pool1"
    pip_name                         = ["tmppip1"]
    lb_outbound_rule_protocol        = "Tcp"
    lb_outbound_rule_allocated_ports = "8"
    lb_outbound_rule_idle_timeout    = "7"
  }
  outrule2 = {
    pip_name                         = ["tmppip1", "tmppip2"]
    lb_backend_pool_name             = "pool2"
    lb_outbound_rule_protocol        = "Udp"
    lb_outbound_rule_allocated_ports = "8"
    lb_outbound_rule_idle_timeout    = "8"
  }
}
```
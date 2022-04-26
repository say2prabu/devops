## terraform-azurerm-aks
Terraform module to create Azure Kubernetes Service

## Description
Azure Kubernetes Service (AKS) simplifies deploying a managed Kubernetes cluster in Azure by offloading the operational overhead to Azure. As a hosted Kubernetes service, Azure handles critical tasks, like health monitoring and maintenance. Since Kubernetes masters are managed by Azure, you only manage and maintain the agent nodes.

## Module example use
```hcl
module "aks" {
  source = "../../modules/terraform-azurerm-aks"

  name                   = "demoaks"
  resource_group_name    = "demo-rsg"
  node_resource_group    = "demo-rsg-nodes"
  location               = "westeurope"
  vnet_subnet_id         = "SubnetIdHere"
  dns_prefix             = "demoaks"
  tenant_id              = "TenantIdHere"
  admin_group_object_ids = ["ADGroupIdHere"]
  tags = {
    "AtosManaged" = "true"
  }
}
```

## License
Atos, all rights protected - 2021.

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_kubernetes_cluster.aks_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aci_connector_linux"></a> [aci\_connector\_linux](#input\_aci\_connector\_linux) | Specifies the ACI connector addon configuration. | <pre>object({<br>    enabled     = bool<br>    subnet_name = string<br>  })</pre> | <pre>{<br>  "enabled": false,<br>  "subnet_name": null<br>}</pre> | no |
| <a name="input_admin_group_object_ids"></a> [admin\_group\_object\_ids](#input\_admin\_group\_object\_ids) | (Optional) A list of Object IDs of Azure Active Directory Groups which should have Admin Role on the Cluster. | `list(string)` | `[]` | no |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | (Required) Specifies the Admin Username for the AKS cluster worker nodes. Changing this forces a new resource to be created. | `string` | `"azadmin"` | no |
| <a name="input_automatic_channel_upgrade"></a> [automatic\_channel\_upgrade](#input\_automatic\_channel\_upgrade) | (Optional) The upgrade channel for this Kubernetes Cluster. Possible values are patch, rapid, and stable. | `string` | `"stable"` | no |
| <a name="input_azure_policy"></a> [azure\_policy](#input\_azure\_policy) | Specifies the Azure Policy addon configuration. | <pre>object({<br>    enabled = bool<br>  })</pre> | <pre>{<br>  "enabled": false<br>}</pre> | no |
| <a name="input_azure_rbac_enabled"></a> [azure\_rbac\_enabled](#input\_azure\_rbac\_enabled) | (Optional) Is Role Based Access Control based on Azure AD enabled? | `bool` | `true` | no |
| <a name="input_default_node_pool_availability_zones"></a> [default\_node\_pool\_availability\_zones](#input\_default\_node\_pool\_availability\_zones) | Specifies the availability zones of the default node pool | `list(string)` | <pre>[<br>  "1",<br>  "2",<br>  "3"<br>]</pre> | no |
| <a name="input_default_node_pool_enable_auto_scaling"></a> [default\_node\_pool\_enable\_auto\_scaling](#input\_default\_node\_pool\_enable\_auto\_scaling) | (Optional) Whether to enable auto-scaler. Defaults to false. | `bool` | `true` | no |
| <a name="input_default_node_pool_enable_host_encryption"></a> [default\_node\_pool\_enable\_host\_encryption](#input\_default\_node\_pool\_enable\_host\_encryption) | (Optional) Should the nodes in this Node Pool have host encryption enabled? Defaults to false. | `bool` | `false` | no |
| <a name="input_default_node_pool_enable_node_public_ip"></a> [default\_node\_pool\_enable\_node\_public\_ip](#input\_default\_node\_pool\_enable\_node\_public\_ip) | (Optional) Should each node have a Public IP Address? Defaults to false. Changing this forces a new resource to be created. | `bool` | `false` | no |
| <a name="input_default_node_pool_max_count"></a> [default\_node\_pool\_max\_count](#input\_default\_node\_pool\_max\_count) | (Required) The maximum number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be greater than or equal to min\_count. | `number` | `10` | no |
| <a name="input_default_node_pool_max_pods"></a> [default\_node\_pool\_max\_pods](#input\_default\_node\_pool\_max\_pods) | (Optional) The maximum number of pods that can run on each agent. Changing this forces a new resource to be created. | `number` | `50` | no |
| <a name="input_default_node_pool_min_count"></a> [default\_node\_pool\_min\_count](#input\_default\_node\_pool\_min\_count) | (Required) The minimum number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be less than or equal to max\_count. | `number` | `3` | no |
| <a name="input_default_node_pool_name"></a> [default\_node\_pool\_name](#input\_default\_node\_pool\_name) | Specifies the name of the default node pool | `string` | `"system"` | no |
| <a name="input_default_node_pool_node_count"></a> [default\_node\_pool\_node\_count](#input\_default\_node\_pool\_node\_count) | (Optional) The initial number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be a value in the range min\_count - max\_count. | `number` | `3` | no |
| <a name="input_default_node_pool_node_labels"></a> [default\_node\_pool\_node\_labels](#input\_default\_node\_pool\_node\_labels) | (Optional) A list of Kubernetes taints which should be applied to nodes in the agent pool (e.g key=value:NoSchedule). Changing this forces a new resource to be created. | `map(any)` | `{}` | no |
| <a name="input_default_node_pool_node_taints"></a> [default\_node\_pool\_node\_taints](#input\_default\_node\_pool\_node\_taints) | (Optional) A map of Kubernetes labels which should be applied to nodes in this Node Pool. Changing this forces a new resource to be created. | `list(string)` | `[]` | no |
| <a name="input_default_node_pool_os_disk_type"></a> [default\_node\_pool\_os\_disk\_type](#input\_default\_node\_pool\_os\_disk\_type) | (Optional) The type of disk which should be used for the Operating System. Possible values are Ephemeral and Managed. Defaults to Managed. Changing this forces a new resource to be created. | `string` | `"Ephemeral"` | no |
| <a name="input_default_node_pool_subnet_address_prefix"></a> [default\_node\_pool\_subnet\_address\_prefix](#input\_default\_node\_pool\_subnet\_address\_prefix) | Specifies the address prefix of the subnet that hosts the default node pool | `list(string)` | <pre>[<br>  "10.0.0.0/20"<br>]</pre> | no |
| <a name="input_default_node_pool_subnet_name"></a> [default\_node\_pool\_subnet\_name](#input\_default\_node\_pool\_subnet\_name) | Specifies the name of the subnet that hosts the default node pool | `string` | `"SystemSubnet"` | no |
| <a name="input_default_node_pool_vm_size"></a> [default\_node\_pool\_vm\_size](#input\_default\_node\_pool\_vm\_size) | Specifies the vm size of the default node pool | `string` | `"Standard_F8s_v2"` | no |
| <a name="input_dns_prefix"></a> [dns\_prefix](#input\_dns\_prefix) | (Optional) DNS prefix specified when creating the managed cluster. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_http_application_routing"></a> [http\_application\_routing](#input\_http\_application\_routing) | Specifies the HTTP Application Routing addon configuration. | <pre>object({<br>    enabled = bool<br>  })</pre> | <pre>{<br>  "enabled": false<br>}</pre> | no |
| <a name="input_ingress_application_gateway"></a> [ingress\_application\_gateway](#input\_ingress\_application\_gateway) | Specifies the Application Gateway Ingress Controller addon configuration. | <pre>object({<br>    enabled      = bool<br>    gateway_id   = string<br>    gateway_name = string<br>    subnet_cidr  = string<br>    subnet_id    = string<br>  })</pre> | <pre>{<br>  "enabled": false,<br>  "gateway_id": null,<br>  "gateway_name": null,<br>  "subnet_cidr": null,<br>  "subnet_id": null<br>}</pre> | no |
| <a name="input_kube_dashboard"></a> [kube\_dashboard](#input\_kube\_dashboard) | Specifies the Kubernetes Dashboard addon configuration. | <pre>object({<br>    enabled = bool<br>  })</pre> | <pre>{<br>  "enabled": false<br>}</pre> | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | Specifies the AKS Kubernetes version | `string` | `"1.21.1"` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) Specifies the location where the AKS cluster will be deployed. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Required) Specifies the name of the AKS cluster. | `string` | n/a | yes |
| <a name="input_network_dns_service_ip"></a> [network\_dns\_service\_ip](#input\_network\_dns\_service\_ip) | Specifies the DNS service IP | `string` | `"10.2.0.10"` | no |
| <a name="input_network_docker_bridge_cidr"></a> [network\_docker\_bridge\_cidr](#input\_network\_docker\_bridge\_cidr) | Specifies the Docker bridge CIDR | `string` | `"172.17.0.1/16"` | no |
| <a name="input_network_plugin"></a> [network\_plugin](#input\_network\_plugin) | Specifies the network plugin of the AKS cluster | `string` | `"azure"` | no |
| <a name="input_network_service_cidr"></a> [network\_service\_cidr](#input\_network\_service\_cidr) | Specifies the service CIDR | `string` | `"10.2.0.0/24"` | no |
| <a name="input_node_resource_group"></a> [node\_resource\_group](#input\_node\_resource\_group) | The name of the Resource Group where the Kubernetes Nodes should exist. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_oms_agent"></a> [oms\_agent](#input\_oms\_agent) | Specifies the OMS agent addon configuration. | <pre>object({<br>    enabled                    = bool<br>    log_analytics_workspace_id = string<br>  })</pre> | <pre>{<br>  "enabled": true,<br>  "log_analytics_workspace_id": null<br>}</pre> | no |
| <a name="input_outbound_type"></a> [outbound\_type](#input\_outbound\_type) | (Optional) The outbound (egress) routing method which should be used for this Kubernetes Cluster. Possible values are loadBalancer and userDefinedRouting. Defaults to loadBalancer. | `string` | `"userDefinedRouting"` | no |
| <a name="input_private_cluster_enabled"></a> [private\_cluster\_enabled](#input\_private\_cluster\_enabled) | Should this Kubernetes Cluster have its API server only exposed on internal IP addresses? This provides a Private IP Address for the Kubernetes API on the Virtual Network where the Kubernetes Cluster is located. Defaults to false. Changing this forces a new resource to be created. | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) Specifies the name of the resource group. | `string` | n/a | yes |
| <a name="input_role_based_access_control_enabled"></a> [role\_based\_access\_control\_enabled](#input\_role\_based\_access\_control\_enabled) | (Required) Is Role Based Access Control Enabled? Changing this forces a new resource to be created. | `bool` | `true` | no |
| <a name="input_sku_tier"></a> [sku\_tier](#input\_sku\_tier) | (Optional) The SKU Tier that should be used for this Kubernetes Cluster. Possible values are Free and Paid (which includes the Uptime SLA). Defaults to Free. | `string` | `"Free"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) Specifies the tags of the bastion host | `map` | `{}` | no |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | (Required) The tenant id of the system assigned identity which is used by master components. | `string` | n/a | yes |
| <a name="input_vnet_subnet_id"></a> [vnet\_subnet\_id](#input\_vnet\_subnet\_id) | (Optional) The ID of a Subnet where the Kubernetes Node Pool should exist. Changing this forces a new resource to be created. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Specifies the resource id of the AKS cluster. |
| <a name="output_kube_config_raw"></a> [kube\_config\_raw](#output\_kube\_config\_raw) | Contains the Kubernetes config to be used by kubectl and other compatible tools. |
| <a name="output_kubelet_identity_object_id"></a> [kubelet\_identity\_object\_id](#output\_kubelet\_identity\_object\_id) | Specifies the object id of the kubelet identity of the AKS cluster. |
| <a name="output_name"></a> [name](#output\_name) | Specifies the name of the AKS cluster. |
| <a name="output_node_resource_group"></a> [node\_resource\_group](#output\_node\_resource\_group) | Specifies the resource id of the auto-generated Resource Group which contains the resources for this Managed Kubernetes Cluster. |
| <a name="output_private_fqdn"></a> [private\_fqdn](#output\_private\_fqdn) | The FQDN for the Kubernetes Cluster when private link has been enabled, which is only resolvable inside the Virtual Network used by the Kubernetes Cluster. |

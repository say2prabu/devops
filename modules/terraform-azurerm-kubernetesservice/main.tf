/*
* ## terraform-azurerm-kubernetesservice
* Terraform module to create Azure Kubernetes Service
* 
* ## Description
* Azure Kubernetes Service (AKS) simplifies deploying a managed Kubernetes cluster in Azure by offloading the operational overhead to Azure. As a hosted Kubernetes service, Azure handles critical tasks, like health monitoring and maintenance. Since Kubernetes masters are managed by Azure, you only manage and maintain the agent nodes.
* 
* ## Module example use
* ```hcl
* module "aks" {
*   source = "../../modules/terraform-azurerm-kubernetesservice"
* 
*   name                   = "demoaks"
*   resource_group_name    = "demo-rsg"
*   node_resource_group    = "demo-rsg-nodes"
*   location               = "westeurope"
*   vnet_subnet_id         = "SubnetIdHere"
*   dns_prefix             = "demoaks"
*   tenant_id              = "TenantIdHere"
*   admin_group_object_ids = ["ADGroupIdHere"]
*   tags = {
*     "AtosManaged" = "true"
*   }
* }
* ```
*
* ## License
* Atos, all rights protected - 2021.
*/

resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                      = var.name
  location                  = var.location
  resource_group_name       = var.resource_group_name
  node_resource_group       = var.node_resource_group
 # kubernetes_version        = var.kubernetes_version
  dns_prefix                = var.dns_prefix
  private_cluster_enabled   = var.private_cluster_enabled
  # automatic_channel_upgrade = var.automatic_channel_upgrade
  sku_tier                  = var.sku_tier

  default_node_pool {
    name                   = var.default_node_pool_name
    vm_size                = var.default_node_pool_vm_size
    vnet_subnet_id         = var.vnet_subnet_id
    node_labels            = var.default_node_pool_node_labels
    node_taints            = var.default_node_pool_node_taints
    enable_auto_scaling    = var.default_node_pool_enable_auto_scaling
    enable_host_encryption = var.default_node_pool_enable_host_encryption
    enable_node_public_ip  = var.default_node_pool_enable_node_public_ip
    max_pods               = var.default_node_pool_max_pods
    max_count              = var.default_node_pool_max_count
    min_count              = var.default_node_pool_min_count
    node_count             = var.default_node_pool_node_count
    os_disk_type           = var.default_node_pool_os_disk_type
    tags                   = var.tags
  }

  identity {
    type = "SystemAssigned"
  }

 # addon_profile {
 #   ingress_application_gateway {
 #     enabled     = var.ingress_application_gateway.enabled
 #     gateway_id  = var.ingress_application_gateway.gateway_id
 #     subnet_cidr = var.ingress_application_gateway.subnet_cidr
 #     subnet_id   = var.ingress_application_gateway.subnet_id
 #   }
 #   aci_connector_linux {
 #     enabled     = var.aci_connector_linux.enabled
 #     subnet_name = var.aci_connector_linux.subnet_name
 #   }
 #   azure_policy {
 #     enabled = var.azure_policy.enabled
 #   }
 #   http_application_routing {
 #     enabled = var.http_application_routing.enabled
 #   }
 #   kube_dashboard {
  #    enabled = var.kube_dashboard.enabled
 #   }
 # }

  #role_based_access_control {
  #  enabled = var.role_based_access_control_enabled

  #  azure_active_directory {
  #    managed                = true
  #    tenant_id              = var.tenant_id
  #    admin_group_object_ids = var.admin_group_object_ids
     # azure_rbac_enabled     = var.azure_rbac_enabled
   # }
  #}

  lifecycle {
    ignore_changes = [
      kubernetes_version,
      tags
    ]
  }
}

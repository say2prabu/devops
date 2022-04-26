# terraform-azurerm-cosmosdb
Terraform module to create an Azure Analysis Server

## Description
Azure Analysis Services is a fully managed platform as a service (PaaS) that provides enterprise-grade data models in the cloud. Use advanced mashup and modeling features to combine data from multiple data sources, define metrics, and secure your data in a single, trusted tabular semantic data model. The data model provides an easier and faster way for users to perform ad hoc data analysis using tools like Power BI and Excel.

Created as an Azure resource, Azure Analysis Services server resources support tabular models at the 1200 and higher compatibility levels. DirectQuery, partitions, row-level security, bi-directional relationships, and translations are all supported

This module will create an Azure Analysis Server, however in order to properly configure the Azure Analysis Server there are manual steps that needs to be performed and it will depend on the specific Data Source.

## Azure Analysis Services limitations

There are several limitations that needs to be considered when using this module:

- Azure Analytics services is not available for deployment in Germany West Central region. The available deployment regions and SKU's are: https://docs.microsoft.com/en-us/azure/analysis-services/analysis-services-overview#availability-by-region 

- Azure Analysis Services is unable to join a VNET. The best solution here is to install and configure an On-premises Data Gateway on the VNET, and then configure your Analysis Services servers with the AlwaysUseGateway server property.

- Azure Analysis Services does not support Private Links, VNETs, or Service Tags (https://docs.microsoft.com/en-us/azure/analysis-services/analysis-services-network-faq)

- If your Analysis Services server and storage account are in the same region, communications between them use internal IP address ranges, therefore, configuring a firewall to use Selected networks and specifying an IP address range is not supported. If organization policies require a firewall, it must be configured to allow access from All networks.

- If the storage account is in a different region, configure storage account firewall settings to allow access from Selected networks. In Firewall Address range, specify the IP address range for the region the Analysis Services server is in.

Also there are several limitations related to terraform code and Infrastructure as Code deployment:

- Refrencing an On-Prem Data Gateway is not possible via Terraform code (according to Terraform Registry documentantion : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/analysis_services_server). However this can be done from ARM or Bicep.

- Creating a Sample Data Model is not possible via Terraform/ARM/Bicep.


## Module Example Use
```hcl
module "analysis_services" {
  source = "../../modules/terraform-azurerm-analysisservicesserver"

  name                      = "sieanalysisdevabcd"
  resource_group_name       = "sie-lnd1-d-rsg-dev"
  location                  = "westeurope"
  admin_users               = ["user1@customdomain.onmicrosoft.com"]
  backup_blob_container_uri = "<Paste here Container URI and SAS token>"
  enable_power_bi_service   = "false"
  querypool_connection_mode = "All"
  sku                       = "D1"
  tags                      = {"AtosManaged" = "true"}
  ipv4_firewall_rule        = [{
    name        = "rule1"
    range_end   = "10.0.0.10"
    range_start = "10.0.0.8"
  }]
}

```

## Module Arguments

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `name` | `string` | true | Name of the Azure Analysis Server to be deployed. |
| `resource_group_name` | `string` | true | The name of the resource group in which to create the Analysis Server account. |
| `location` | `string` | true | Resource location. |
| `admin_users` | `string` | false | List of email addresses from Azure AD of admin users |
| `backup_blob_container_uri` | `string` | false | URI and SAS token for a blob container to store backups. |
| `enable_power_bi_service` | `bool` | false | Indicates if the Power BI service is allowed to access or not. |
| `querypool_connection_mode` | `string` | false |Controls how the read-write server is used in the query pool. If this value is set to All then read-write servers are also used for queries. Otherwise with ReadOnly these servers do not participate in query operations. |
| `sku` | `string` | true | SKU for the Analysis Services Server. Possible values are: D1, B1, B2, S0, S1, S2, S4, S8, S9, S8v2 and S9v2. |
| `ipv4_firewall_rule` | `object` | false | One or more ipv4_firewall_rule block(s) as defined below. |
| `tags` | `map` | false | A mapping of tags to assign to the resource. |

For a complete list of all the possible arguments (terraform variables), see the variables.tf file in this modules folder.
## Module outputs

| Name | Description | Value
| --- | --- | --- |
| `id` | The resource ID of the created Azure Analysis Server. | `azurerm_analysis_services_server.analysis_services_server.id` |
| `server_full_name` | The name of the created Azure Analysis Server. | `azurerm_analysis_services_server.analysis_services_server.server_full_name` |

## Root Module usage

If needed, the Azure Analysis Services child module can be called from a root module. Root module example usage:

```hcl
module "analysis_naming" {
  source = "../../modules/terraform-naming"

  azure_region      = var.azure_region
  organization-code = var.organization_code
  environment-code  = var.environment_code
  subscription-code = var.subscription_code
  suffix            = var.backend_suffix
}

module "analysis_resourcegroup" {
  source = "../../modules/terraform-azurerm-resourcegroup"

  name     = module.analysis_naming.resource_group.name
  location = module.analysis_naming.azure_region
  tags     = var.rsg_tags
}
data "azurerm_storage_account" "sa_analysis" {
  name                = var.analysis_storage_account_name
  resource_group_name = var.analysis_sa_resource_group_name
}
data "azurerm_storage_container" "sa_container_analysis" {
  name                 = var.analysis_storage_container_name
  storage_account_name = data.azurerm_storage_account.sa_analysis.name
}
data "azurerm_storage_account_blob_container_sas" "sas" {
  connection_string = data.azurerm_storage_account.sa_analysis.primary_connection_string
  container_name    = var.analysis_storage_container_name
  expiry            = var.sas_expiration
  start             = var.sas_start
  permissions {
    read   = true
    add    = true
    create = true
    write  = true
    delete = false
    list   = true
  }
}

module "analysis_services" {
  source = "../../modules/terraform-azurerm-analysisservicesserver"

  name                      = module.analysis_naming.analysis_services.name_unique
  resource_group_name       = module.analysis_resourcegroup.rsg_name
  location                  = module.analysis_resourcegroup.rsg_location
  admin_users               = var.admin_users
  backup_blob_container_uri = "https://${var.analysis_storage_account_name}.blob.core.windows.net/${var.analysis_storage_container_name}${data.azurerm_storage_account_blob_container_sas.sas.sas}"
  enable_power_bi_service   = var.enable_power_bi_service
  querypool_connection_mode = var.querypool_connection_mode
  sku                       = var.sku
  tags                      = var.tags
  ipv4_firewall_rule        = var.ipv4_firewall_rule
}

```

Example .tfvars usage for root module:

```hcl
azure_region      = "westeurope"
organization_code = "sie"
environment_code  = "d"
subscription_code = "lnd1"

backend_suffix = [
  "dev"
]

admin_users               = ["user1@domain.onmicrosoft.com"]
enable_power_bi_service   = "false"
querypool_connection_mode = "All"
sku                       = "D1"

tags = {
  "AtosManaged" = "true"
  "Owner"       = "user1"
}
rsg_tags = {
  "AtosManaged" = "true"
}

ipv4_firewall_rule = [{
    name        = "rule1"
    range_end   = "10.0.0.10"
    range_start = "10.0.0.8"
  }]

analysis_sa_resource_group_name = "test-analysis"
analysis_storage_account_name = "saccanalysisservices"
analysis_storage_container_name = "container01"
sas_start = "2021-10-24T06:43:46Z"
sas_expiration = "2021-10-28T06:43:46Z"

```

## License
Atos, all rights protected - 2021.
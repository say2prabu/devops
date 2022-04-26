# terraform-azurerm-privateendpoint
Terraform module to create a Private Endpoint (using the Private Link service) to be used with a supported Azure Resource.

## Description
Azure Private Link enables access to Azure PaaS Services (for example, Azure Storage and SQL Database) and Azure hosted customer-owned/partner services over a **private endpoint** in your virtual network.

## Private Endpoint
A private endpoint is a network interface that uses a private IP address from your virtual network. This network interface connects you privately and securely to a service powered by Azure Private Link. By enabling a private endpoint, you're bringing the service into your virtual network.

### Out of scope
This module does not deploy or configure Azure Private DNS (which is common when deploying private endpoints).
For the Siemens showcase custom DNS will be used to resolve the private IP addresses deployed with the private endpoints.
This has been discussed with the Ops team & decided by Dave Smith. Details in https://msdevopsjira.fsc.atos-services.net/browse/DCSAZ-875

## Module example use
```hcl
module "private_endpoint" {
  source = "../../modules/terraform-azurerm-privateendpoint"

  name                        = "unique pe name"
  location                    = "germanywestcentral"
  resource_group_name         = "demo-rsg"
  subnet_id                   = "<subnet_resourceid_where_privateendpoint_is_to_be_created>"
  private_dns_zone_group_name = "unique dns zone group name"
  private_dns_zone_ids        = ["dns zone resource id"]

  private_service_connection_name = "unique name"
  private_connection_resource_id  = "<resourceid_of_resource_for_privateendpoint_to_be_connected>" 
  subresources_name               ="<sub_resource_name>"
}

```
## Module Arguments

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `name` | `object` | true | The name of the private endpoint connection. |
| `location` | `string` | true | The location of the private endpoint. |
| `resource_group_name` | `string` | true | Specifies the Name of the Resource Group within which the Private Endpoint should exist. |
| `subnet_id` | `string` | true | The ID of the Subnet from which Private IP Addresses will be allocated for this Private Endpoint. |
| `private_dns_zone_group_name` | `string` | true | Specifies the Name of the Private DNS Zone Group |
| `private_dns_zone_ids` | `list(string)` | true |  Specifies the list of Private DNS Zones to include within the private_dns_zone_group. |
| `private_service_connection_name` | `string` | true | Specifies the Name of the Private Service Connection. |
| `private_connection_resource_id` | `string` | true | The ID of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to. |
| `subresources_name ` | `string` | true | A list of subresource names which the Private Endpoint is able to connect to. Subresource_names corresponds to group_id.  |

## Module outputs

| Name | Description | Value
| --- | --- | --- |
| `private_endpointid` | The resource id of the created private endpoint. | `azurerm_private_endpoint.private_endpoint.id` |
| `private_endpointname` | The name of the created private endpoint. | `azurerm_private_endpoint.private_endpoint.name` |

## License
Atos, all rights protected - 2021.

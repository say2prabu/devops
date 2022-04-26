# terraform-azurerm-synapse-managed-private-endpoint
Terraform module to create a Synapse Managed Private Endpoint.

## Description
Managed private endpoints are private endpoints created in a Managed Virtual Network associated within an Azure Synapse workspace. Managed private endpoints establish a private link to Azure resources. Azure Synapse manages these private endpoints on your behalf. You can create Managed private endpoints from your Azure Synapse workspace to access Azure services (such as Azure Storage or Azure Cosmos DB) and Azure hosted customer/partner services.

When you use Managed private endpoints, traffic between your Azure Synapse workspace and other Azure resources traverse entirely over the Microsoft backbone network. Managed private endpoints protect against data exfiltration. A Managed private endpoint uses private IP address from your Managed Virtual Network to effectively bring the Azure service that your Azure Synapse workspace is communicating into your Virtual Network. Managed private endpoints are mapped to a specific resource in Azure and not the entire service.

## Module example use
```hcl
module "datalake_managed_privateendpoint" {
  source = "../../modules/terraform-azurerm-synapse-managed-private-endpoint"

  name                 = "ws-mpe-demo001"
  synapse_workspace_id = " <workspace_id> "
  target_resource_id   = " <target_resource_id> "
  subresource_name     = "blob"

}

```
## Module Arguments

| Name                  | Type          | Required | Description                                        |
| --------------------- | ------------- | -------- | -------------------------------------------------- |
| `name`                | `string`      | true     | Specifies the name which should be used for this Managed Private Endpoint. |
| `synapse_workspace_id`| `string`      | true     | The ID of the Synapse Workspace on which to create the Managed Private Endpoint. |
| `target_resource_id`  | `string` | true     | The ID of the Private Link Enabled Remote Resource which this Synapse Private Endpoint should be connected to. |
| `subresource_name`    | `string`      | true     | Specifies the sub resource name which the Synapse Private Endpoint is able to connect to.|


## Module outputs
None

## License
Atos, all rights protected - 2021.

# terraform-azurerm-resourcegroup
Terraform module to create a Resource group.

## Description
A resource group is a container that holds related resources for an Azure solution. The resource group can include all the resources for the solution, or only those resources that will be managed as a group.

## Module example use
```hcl
module "resourcegroup" {
  source = "../../modules/resourcegroup"

  name = "unique name"
  location = "germanywestcentral"
  tags = {
    "AtosManaged" = "true"
    "Environment" = "Development"
  }
}

```
## Module Arguments

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `name` | `object` | true | The resource group name. |
| `location` | `string` | true | The location of the resource group. |
| `tags` | `map(string)` | true | A mapping of tags to assign to the resource group. |

## Module outputs

| Name | Description | Value
| --- | --- | --- |
| `resource_group_name` | The name of the created resource group. | `azurerm_resource_group.rsg.name` |
| `resource_group_location` | The location (Azure region) where the resource group has been created. | `azurerm_resource_group.rsg.location` |
| `resource_group_id` | The resource ID of the created resource group. | `azurerm_resource_group.rsg.id` |

## License
Atos, all rights protected - 2021.

## terraform-azurerm-acr
Terraform module to create Azure Container Registry

## Description
Azure Container Registry is a managed, private Docker registry service based on the open-source Docker Registry 2.0. Create and maintain Azure container registries to store and manage your private Docker container images and related artifacts.

## Module example use
```hcl
module "container_registry" {
  source              = "../../modules/terraform-azurerm-acr"
  name                = "demoacr"
  resource_group_name = "demo-rsg"
  location            = "westeurope"
  sku                 = "Basic"
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
| [azurerm_container_registry.acr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_enabled"></a> [admin\_enabled](#input\_admin\_enabled) | (Optional) Specifies whether the admin user is enabled. Defaults to false. | `string` | `false` | no |
| <a name="input_georeplication_locations"></a> [georeplication\_locations](#input\_georeplication\_locations) | (Optional) A list of Azure locations where the container registry should be geo-replicated. | `list(string)` | `[]` | no |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the ACR instance. This needs to be globally unique within Azure. | `string` | n/a | yes |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | (Optional) Whether public network access is allowed for the container registry. Defaults to true. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the ACR instance. | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | The SKU name of the container registry. Possible values are Basic, Standard and Premium. Classic (which was previously Basic) is supported only for existing resources. | `string` | `"Basic"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_admin_username"></a> [admin\_username](#output\_admin\_username) | Specifies the admin username of the container registry. |
| <a name="output_id"></a> [id](#output\_id) | Specifies the resource id of the container registry. |
| <a name="output_login_server"></a> [login\_server](#output\_login\_server) | Specifies the login server of the container registry. |
| <a name="output_login_server_url"></a> [login\_server\_url](#output\_login\_server\_url) | Specifies the login server url of the container registry. |
| <a name="output_name"></a> [name](#output\_name) | Specifies the name of the container registry. |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | Specifies the name of the resource group. |

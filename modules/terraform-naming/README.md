# terraform-naming
Terraform module to provide naming to other modules, it enforces the naming convention is followed.

## Description
This module generates and provides names to azure resources being deployed via Terraform.
It enforces the DCS Azure naming convention.

## Module example use
```hcl
module "redis_naming" {
  source = "../../modules/terraform-naming"

  azure_region      = "westeurope"
  organization-code = "cu9"
  environment-code  = "p"
  subscription-code = "mgmt"
  suffix            = ["showcase", "afqp"]
}

```

## Module Arguments

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `azure_region` | `string` | true | The Azure location/region to which the resources are being deployed. This will be used to get the corresponding four character Atos code according to Atos DCS naming convention. |
| `organization-code` | `string` | true | A three character Atos code according to Atos DCS naming convention indicating which organization we are deploying this automation for. When for Atos use: ats |
| `environment-code` | `string` | true | A one character Atos code according to Atos DCS naming convention to indicate which environment type will be deployed to. Example 'd' for Development, 't' for Test etc. |
| `subscription-code` | `string` | true | A four character Atos code according to Atos DCS naming convention to indicate which subscription we are deploying the automation to. Example 'mgmt' for management, 'lnd1' for the 1st landingzone. |
| `suffix` | `list(string)` | false | Possible suffixes to add to the name being generated. Example 'showcase', 'afqp', 'backend'. No limits on number of characters. |


## Module outputs
The module outputs the names generated for the resources, please see the outputs.tf file for details.


## Using the naming module - example
```hcl
module "appsvc_resourcegroup" {
  source = "../../modules/terraform-azurerm-resourcegroup"

  rsg_name     = module.appsvc_naming.resource_group.name
  rsg_location = module.appsvc_naming.azure_region
}

```

## License
Atos, all rights protected - 2021.
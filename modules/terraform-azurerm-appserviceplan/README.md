# terraform-azurerm-appserviceplan
Terraform module to create an Azure app service plan.

## Description
An App Service plan defines a set of compute resources for a web app to run. These compute resources are analogous to the server farm in conventional web hosting. One or more apps can be configured to run on the same computing resources (or in the same App Service plan).

When you create an App Service plan in a certain region (for example, West Europe), a set of compute resources is created for that plan in that region. Whatever apps you put into this App Service plan run on these compute resources as defined by your App Service plan. Each App Service plan defines:

Operating System (Windows, Linux)
Region (West US, East US, etc.)
Number of VM instances
Size of VM instances (Small, Medium, Large)
Pricing tier (Free, Shared, Basic, Standard, Premium, PremiumV2, PremiumV3, Isolated)

This module will create an app service plan as per the requirements of the Siemens App Transformation showcase. 

## Module Example Use
```hcl
module "appservice_plan" {
  source              = "../../modules/terraform-azurerm-appserviceplan"
  appsvcplan_name     = "demoappserviceplan04102021"
  resource_group_name = "demo-rsg"
  location            = "westeurope"
  service_plan = {
  kind = "Windows"
  size = "P1v2"
  tier = "PremiumV2"
}
  tags = {
    "AtosManaged" = "true"
    "Owner"       = "PSCC"
    "Environment" = "Acceptance"
  }
}

```

## Module Arguments

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `appsvcplan_name` | `string` | true | Specifies the name of the app service plan. |
| `resource_group_name` | `string` | true | The name of the resource group in which to create the app service plan. |
| `location` | `string` | true | Specifies the supported Azure location where the resource exists. |
| `service_plan` | `map` | true | Defines the kind, size and tier for app service plan
| `tags` | `map` | false | A mapping of tags to assign to the resource. |

## Module outputs

| Name | Description | Value
| --- | --- | --- |
| `id` | The resource ID of the created app service plan. | `azurerm_app_service_plan.main.id` |

## License
Atos, all rights protected - 2021.
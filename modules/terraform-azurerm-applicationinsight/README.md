# terraform-azurerm-appserviceplan
Terraform module to create an application insights.

## Description
Application Insights, a feature of Azure Monitor, is an extensible Application Performance Management (APM) service for developers and DevOps professionals. Use it to monitor your live applications. It will automatically detect performance anomalies, and includes powerful analytics tools to help you diagnose issues and to understand what users actually do with your app. It's designed to help you continuously improve performance and usability.

This module will create an application insights as per the requirements of the Siemens App Transformation showcase. 

## Module Example Use
```hcl
module "app_insights" {
  source                    = "../../modules/terraform-azurerm-applicationinsight"
  appinsights_name          = "demoappinsights041021"
  resource_group_name       = "demo-rsg"
  location                  = "westeurope"
  application_insights_type = "web"
  retention_in_days         = "90"
  disable_ip_masking        = true
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
| `appinsights_name` | `string` | true | Specifies the name of the app Insights. |
| `resource_group_name` | `string` | true | The name of the resource group in which to create the app service plan. |
| `location` | `string` | true | Specifies the supported Azure location where the resource exists. |
| `application_insights_type` | `string` | true | Defines the type of application insights
| `retention_in_days` | `string` | true | number of days for the logs to retained
| `disable_ip_masking` | `string` | false | By default the real client ip is masked as 0.0.0.0 in the logs. Use this argument to disable masking and log the real client ip
| `tags` | `map` | false | A mapping of tags to assign to the resource. |

## Module outputs

| Name | Description | Value
| --- | --- | --- |
| `id` | The resource ID of the created app service plan. | `azurerm_application_insights.main.id` |

## License
Atos, all rights protected - 2021.
# terraform-azurerm-functionapp
Terraform module to create an Azure function app.

## Description
Azure Function is a serverless compute service that enables user to run event-triggered code without having to provision or manage infrastructure. Being as a trigger-based service, it runs a script or piece of code in response to a variety of events.

This module will create a function application as per the requirements of the Siemens App Transformation showcase. 

NOTE : Enabling Application Insights for the function app is optional based on "application_insights_enabled" variable. Also, Application Insights needs to created as an another resource using "terraform-azurerm-applicationinsight" module and needs to be referenced in this if we are going to enable application insights. Application Insights won't be created using this module. We only attach the function app to existing AppInisghts in the function app module.

## Module Example Use
```hcl
module "function_app" {
  source                 = "../../modules/terraform-azurerm-functionapp"
  function_app_name      = "demofunctionapp"
  resource_group_name    = "demorg"
  location               = "westeurope"
  app_service_plan_id    = {
    kind = "Windows"
    size = "P1v2"
    tier = "PremiumV2"
  }
  tags                   = {
    "AtosManaged" = "true"
    "Owner"       = "PSCC"
    "Environment" = "Acceptance"
  }
  site_config             = {
  always_on = true
  ftps_state = "FtpsOnly"
  http2_enabled = false
  min_tls_version = "1.2"
}
  connection_strings      = [
   {
      name  = "test"
      type  = "SQLAzure"
      value = "test123"
   }]
  storage_account_name          = azurerm_storage_account.example.name
  storage_account_access_key    = azurerm_storage_account.example.primary_access_key  
  subnet_id                     = data.azurerm_subnet.appsvc_subnet.id
  application_insights_enabled  = true
  application_insights_id       = module.afqp_app_insights.id # this is required only when "application_insights_enabled" is true

}

```

## Module Arguments

| Name                                  | Type     | Required | Description                                                             |
| --------------------------------------| -------- | -------- | ----------------------------------------------------------------------- |
| `function_app_name `                  | `string` | true     | Specifies the name of the function app.                                 |
| `resource_group_name`                 | `string` | true     | The name of the resource group in which to create the app service plan. |
| `location`                            | `string` | true     | Specifies the supported Azure location where the resource exists.       |
| `app_service_plan_id`                 | `map`    | true     | Defines the kind, size and tier for app service plan                    |
| `tags`                                | `map`    | false    | A mapping of tags to assign to the resource.                            |
| `site_config`                         | `map`    | true     | Defines various site configs                                            |
| `always_on`                           | `bool`   | false    | Specifies whether always_on true or not.                                |
| `dotnet_framework_version`            | `string` | false    | Specifies the dotnet_framework_version.                                 |
| `ftps_state`                          | `string` | false    | Specifies the ftps state.                                               |
| `connection_strings`                  | `map`    | false    | Defines various connection strings                                      |
| `name`                                | `string` | false    | Specifies name of the connection string.                                |
| `type`                                | `string` | false    | Specifies the type of connection ex: SQLAzure or SQLServer.             |
| `value`                               | `string` | false    | value of the connection string.                                         |
| `http2_enabled`                       | `bool`   | false    | Specifies whether https is enabled or not.                              |
| `min_tls_version`                     | `string` | false    | Specifies the minumum TLS version required.                             |
| `subnet_id `                          | `string` | true     | id of the subnet for vnet integration                                   |
| `application_insights_enabled `       | `string` | true     | parmater to enable or disable app insights                              |
| `application_insights_id `            | `string` | true     | id of the subnet for vnet integration                                   |


## Module outputs

| Name                | Description                                      | Value                                |
| ------------------- | ------------------------------------------------ | -------------------------------------|
| `id`                | The resource ID of the created app service plan. | `azurerm_function_app.main.id`       |
| `rsg_location`      | The resource ID of the created app service plan. | `azurerm_function_app.main.location` |
| `function_app_name` | The resource ID of the created app service plan. | `azurerm_function_app.main.name`     |

## License
Atos, all rights protected - 2021.
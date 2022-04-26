# terraform-azurerm-appserviceplan
Terraform module to create an Azure app service plan.

## Description
Azure App Service lets you create apps faster with a one-of-a kind cloud service to quickly and easily create enterprise-ready web and mobile apps for any platform or device and deploy them on a scalable and reliable cloud infrastructure.

This module will create an app service as per the requirements of the Siemens App Transformation showcase. 

## Module Example Use
```hcl
module "app_service" {
  source              = "../../modules/terraform-azurerm-appservice"
  appservice_name     = "demoappservice"
  resource_group_name = "demorg"
  location            = "westeurope"
  app_service_plan_id = {
    kind = "Windows"
    size = "P1v2"
    tier = "PremiumV2"
  }
  tags = {
    "AtosManaged" = "true"
    "Owner"       = "PSCC"
    "Environment" = "Acceptance"
  }
  site_config = {
  always_on = true
  dotnet_framework_version = "v4.0"
  ftps_state = "FtpsOnly"
  http2_enabled = false
  min_tls_version = "1.2"
}
  connection_strings = [
   {
      name  = "test"
      type  = "SQLAzure"
      value = "test123"
   },
  appservice_vnet_name = var.appservice.vnet_name
  appsrevice_vnet_rsgname = var.appservice.vnet_rsgname
  appservice_subnet_name = var.appservice.subnet_name

}

```

## Module Arguments

| Name                       | Type     | Required | Description                                                             |
| -------------------------- | -------- | -------- | ----------------------------------------------------------------------- |
| `appservice_name `         | `string` | true     | Specifies the name of the app service plan.                             |
| `resource_group_name`      | `string` | true     | The name of the resource group in which to create the app service plan. |
| `location`                 | `string` | true     | Specifies the supported Azure location where the resource exists.       |
| `app_service_plan_id`      | `map`    | true     | Defines the kind, size and tier for app service plan                    |
| `tags`                     | `map`    | false    | A mapping of tags to assign to the resource.                            |
| `site_config`              | `map`    | true     | Defines various site configs                                            |
| `always_on`                | `bool`   | false    | Specifies whether always_on true or not.                                |
| `dotnet_framework_version` | `string` | false    | Specifies the dotnet_framework_version.                                 |
| `ftps_state`               | `string` | false    | Specifies the ftps state.                                               |
| `connection_strings`       | `map`    | false    | Defines various connection strings                                      |
| `name`                     | `string` | false    | Specifies name of the connection string.                                |
| `type`                     | `string` | false    | Specifies the type of connection ex: SQLAzure or SQLServer.             |
| `value`                    | `string` | false    | value of the connection string.                                         |
| `http2_enabled`            | `bool`   | false    | Specifies whether https is enabled or not.                              |
| `min_tls_version`          | `string` | false    | Specifies the minumum TLS version required.                             |
| `appservice_vnet_name`     | `string` | true     | vnet name that appservice going to integrate                            |
| `appsrevice_vnet_rsgname`  | `string` | true     | vnet resource group that app service going to integrate.                |
| `appservice_subnet_name`   | `string` | true     | subnet name that app service going to integrate.                        |

## Module outputs

| Name | Description                                      | Value                         |
| ---- | ------------------------------------------------ | ----------------------------- |
| `id` | The resource ID of the created app service plan. | `azurerm_app_service.main.id` |

## License
Atos, all rights protected - 2021.
# Resource Group
This Application will create a resource group

# Example YAML
```yaml
# Create (Deployment)--------------------------------------------
Kind: Deployment
Name: test-rg
Application: resource-group
Vars:
  azure_region: westeurope
  organization-code: sei
  subscription-code: ind1
  environment-code: d
  suffix:
    - show
    - test
  rsg_location: West Europe
  tags :
    testing: resource-group
```

# Application Variables
| Name | Type | Required | Description | Example | Default Value 
| --- | --- | --- | --- | --- | --- 
| `azure_region` | `string` | true | The Azure location/region to which the resources are being deployed. This will be used to get the corresponding four character Atos code according to Atos DCS naming convention. | "westeurope" | NA
| `organization-code` | `string` | true | A three character Atos code according to Atos DCS naming convention indicating which organization we are deploying this automation for. When for Atos use: ats | "ats" | NA
| `environment-code` | `string` | true | A one character Atos code according to Atos DCS naming convention to indicate which environment type will be deployed to. Example 'd' for Development, 't' for Test etc. | "d" |NA
| `subscription-code` | `string` | true | A four character Atos code according to Atos DCS naming convention to indicate which subscription we are deploying the automation to. Example 'mgmt' for management, 'lnd1' for the 1st landingzone. | "ind1" | NA
| `suffix` | `list(string)` | false | Possible suffixes to add to the name being generated. Example 'showcase', 'afqp', 'backend'. No limits on number of characters. | ["show","test"]
| `rsg_location` | `string` | true | The location in which your resource group resides| "West Europe"| NA
| `tags` | `map` | false | A mapping of tags to assign to the resource. | {"key": "value"} | {"key": "value"}
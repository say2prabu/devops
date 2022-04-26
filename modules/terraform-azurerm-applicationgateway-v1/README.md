# terraform-azurerm-applicationgateway
Terraform module to create WAF (Web Application Firewall) on Azure Application Gateway.

## Description
Azure Application Gateway is a web traffic load balancer that enables you to manage traffic to your web applications. 
Application layer (OSI layer 7) load balancing.
Azure Web Application Firewall (WAF) on Azure Application Gateway provides centralized protection of your web applications from common exploits and vulnerabilities.

## Module example use
```hcl
module "appgw" {
  source = "../../modules/terraform-azurerm-applicationgateway"

  appgw_name = module.naming.application_gateway.name
  appgw_rsg = var.appgw_rsg
  appgw_location = var.azure_region
  enable_http2 = var.enable_http2
  tags = var.tags
  appgw_sku_size = var.appgw_sku_size
  appgw_tier = var.appgw_tier
  appgw_capacity = var.appgw_capacity
  waf_enabled = var.waf_enabled
  waf_configuration = var.waf_configuration
  vnet_name = var.vnet_name
  subnet_name = var.subnet_name
  vnet_rsg_name = var.vnet_rsg_name
  frontend_ip_configuration_name = var.frontend_ip_configuration_name
  private_ip_address= var.private_ip_address
  frontend_port_number = var.frontend_port_number
  ssl_certificate = var.ssl_certificate
  probe = var.probe
  backendpools = var.backendpools
  http_listener_protocol = var.http_listener_protocol
  http_settings_name = var.http_settings_name
  cookie_based_affinity = var.cookie_based_affinity
  backend_port = var.backend_port
  backend_protocol = var.backend_protocol
  request_timeout = var.request_timeout
  connection_draining = var.connection_draining
  drain_timeout = var.drain_timeout
  hostfrombackend = var.hostfrombackend
  custom_probe = var.custom_probe
  url_path_map_name = var.url_path_map_name
  path_rule = var.path_rule
  routing_rule_name = var.routing_rule_name
  routing_rule_type = var.routing_rule_type
  defaultpool = var.defaultpool
}
```
  # WAF on Application Gateway settings
  waf_configuration {
    enabled                  = var.waf_enabled
    firewall_mode            = coalesce(var.waf_configuration != null ? var.waf_configuration.firewall_mode : null, "Detection")
    rule_set_type            = coalesce(var.waf_configuration != null ? var.waf_configuration.rule_set_type : null, "OWASP")
    rule_set_version         = coalesce(var.waf_configuration != null ? var.waf_configuration.rule_set_version : null, "3.0")
    file_upload_limit_mb     = coalesce(var.waf_configuration != null ? var.waf_configuration.file_upload_limit_mb : null, 100)
    max_request_body_size_kb = coalesce(var.waf_configuration != null ? var.waf_configuration.max_request_body_size_kb : null, 128)
  }
## Module Arguments
| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `appgw_name` | `string` | true | The name of this Application Gateway. |
| `appgw_rsg` | `string` | true | Resource Group this Application Gateway is deployed in. |
| `appgw_location` | `string` | true | Application Gateway location. |
| `enable_http2` | `bool` | true | HTTP2 enabled on the application gateway. Defaults to false. |
| `tags` | `map(string)` | true | Tag value. |
| `appgw_sku_size` | `string` | true | Application Gateway SKU size. Possible values: Standard_Small, Standard_Medium, Standard_Large, Standard_v2, WAF_Medium, WAF_Large, and WAF_v2. |
| `appgw_tier` | `string` | true | Application Gateway SKU tier. Possible values are Standard, Standard_v2, WAF and WAF_v2. |
| `appgw_capacity` | `number` | true | The Capacity of the SKU to use for this Application Gateway. When using a V1 SKU this value must be between 1 and 32. |
| `waf_enabled` | `bool` | true | WAF (Web Aplication Firewall) on Application Gateway. Defaults to true. |
| `waf_configuration` | `object({})` | true | WAF configuration. Block (Block1) is defined below. Please read for details. Defaults to null. |
| `vnet_name` | `string` | true | Virtual Network this Application Gateway is deployed in. |
| `subnet_name` | `string` | true | Subnet this Application Gateway is deployed in. |
| `vnet_rsg_name` | `string` | true | Virtual Network resource group name. |
| `frontend_ip_configuration_name` | `string` | true | he name of the Frontend IP Configuration. |
| `private_ip_address` | `string` | true | The Private IP Address to use for the Application Gateway. Pick one from the subnet this Application Gateway is deployed in. Static allocation. |
| `frontend_port_number` | `number` | true | Enter a frontend port number for the listener. You can use well known ports, such as port 80 and 443, or any port ranging from 1 to 65502 (v1 SKU). |
| `ssl_certificate` | `object({})` | true | SSL certficate configuration. Block (Block2) is defined below. Please read for details.|
| `probe` | `list(object({}))` | true | Probe configuration. Block (Block3) is defined below. Please read for details. |
| `backendpools` | `list(object({}))` | true | Backend Pools. Supply a name for the pool and a list of fqdn's/IP's which should be part of the backend address pool. Block (Block4) is defined below. Please read for details. |
| `http_listener_protocol` | `string` | true | The Protocol to use for HTTP Listener. Possible values are Http and Https. |
| `http_settings_name` | `string` | true | The name of the Backend HTTP Settings Collection - between 1 and 80 characters. Must begin with a letter or number, end with a letter, number or underscore, and may contain only letters, numbers, underscores, periods, or hyphens. |
| `cookie_based_affinity` | `string` | true | Http Settings: Is Cookie-Based Affinity enabled? Possible values are Enabled and Disabled. |
| `backend_port` | `number` | true | The port which should be used for this Backend HTTP Settings Collection. |
| `backend_protocol` | `string` | true | Http Settings: The Protocol which should be used. Possible values are Http and Https. |
| `request_timeout` | `number` | true | Http Settings: The request timeout is the number of seconds that the application gateway will wait to receive a response from the backend pool before it returns a “connection timed out” error message - between 1 and 86400 seconds. |
| `connection_draining` | `bool` | true | Http Settings: If connection draining is enabled or not. Defaults to false. |
| `drain_timeout` | `number` | true | Http Settings: The number of seconds connection draining is active. Acceptable values are from 1 second to 3600 seconds. Specify this value even if connection_draining is set to false. |
| `hostfrombackend` | `bool` | true | Http Settings: Pick host name from backend target. Defaults to true. |
| `custom_probe` | `string` | true | Http Settings: The name of an associated HTTP Probe. |
| `url_path_map_name` | `string` | true | The Name of the URL Path Map which should be associated with this Routing Rule. |
| `path_rule` | `list(object({}))` | true | Path based rules. Forms a part of URL path map. Block (Block5) is defined below. Please read for details. |
| `routing_rule_name` | `string` | true | The Name of this Request Routing Rule - between 1 and 80 characters. Must begin with a letter or number, end with a letter, number or underscore, and may contain only letters, numbers, underscores, periods, or hyphens. |
| `routing_rule_type` | `string` | true | The Type of Routing that should be used for this Rule. Possible values are Basic and PathBasedRouting. |
| `defaultpool` | `string` | true |  Default pool name to be used in Request Routing Rule.|


### Block1 - waf_configuration
| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `firewall_mode` | `string` | true | The Web Application Firewall Mode. Possible values are Detection and Prevention. |
| `rule_set_type` | `string` | true | The Type of the Rule Set used for this Web Application Firewall. Currently, only OWASP is supported. |
| `rule_set_version` | `string` | true | The Version of the Rule Set used for this Web Application Firewall. Possible values are 2.2.9, 3.0, and 3.1. |
| `file_upload_limit_mb` | `string` | true | The File Upload Limit in MB. Accepted values are in the range 1MB to 750MB for the WAF_v2 SKU, and 1MB to 500MB for all other SKUs. Defaults to 100MB. |
| `max_request_body_size_kb` | `string` | true | The Maximum Request Body Size in KB. Accepted values are in the range 1KB to 128KB. Defaults to 128KB. |

```
Note: this block defaults to NULL, which leads to the following configuration for WAF. Unless you want to change this configuration, please let the default value stay as null.

firewall_mode            = "Detection"
rule_set_type            = "OWASP"
rule_set_version         = "3.0"
file_upload_limit_mb     = 100
max_request_body_size_kb = 128

Example:
default = null

```
### Block2 - ssl_certificate
Since decision has been made to use v1 gateway SKU, keyvault can't be used.
TLS termination with Key Vault certificates is limited to the v2 SKUs.
Copy the certificate into the repo. Provide that path in 'data'.

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `name` | `string` | true | The Name of the SSL certificate that is unique within this Application Gateway |
| `data` | `string` | true | PFX certificate. |
| `password` | `string` | true | Password for the pfx file specified in data. |

```
Example:
default = {
    name     = "appgw-ssl-cert",
    data     = "./mycert.com.pfx",
    password = "Password123"
  }
```
### Block3 - probe
Note: You may use the values as is from the example provided below, with name of your choice. Connection to app service in the backend (https).

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `name` | `string` | true | The Name of the Probe. |
| `protocol` | `string` | true | The Protocol used for this Probe. Possible values are Http and Https. |
| `interval` | `number` | true | The Interval between two consecutive probes in seconds. Possible values range from 1 second to a maximum of 86,400 seconds. |
| `timeout` | `number` | true | The Timeout used for this Probe, which indicates when a probe becomes unhealthy. Possible values range from 1 second to a maximum of 86,400 seconds. |
| `unhealthy_threshold` | `number` | true | The Unhealthy Threshold for this Probe, which indicates the amount of retries which should be attempted before a node is deemed unhealthy. Possible values are from 1 - 20 seconds. |
| `pick_host_name_from_backend_http_settings` | `bool` | true | Whether the host header should be picked from the backend http settings. |
| `host` | `string` | true | The Hostname used for this Probe. If the Application Gateway is configured for a single site, by default the Host name should be specified as ‘127.0.0.1’, unless otherwise configured in custom probe. *Cannot be set if pick_host_name_from_backend_http_settings is set to true. Use value NULL* |
| `path` | `string` | true | The Path used for this Probe. |


```
Example:
default = [
    {
      name                                      = "probe1",
      protocol                                  = "https",
      interval                                  = 30,
      timeout                                   = 30,
      unhealthy_threshold                       = 3,
      pick_host_name_from_backend_http_settings = true,
      host                                      = null
      path                                      = "/"
    }
  ]
```

### Block4 - backendpools
| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `name` | `string` | true | The name of the Backend Address Pool. |
| `fqdns` | `list(string)` | true | A list of FQDN's which should be part of the Backend Address Pool. |
| `ip_addresses` | `list(string)` | true | A list of IP Addresses which should be part of the Backend Address Pool. |

```
Example:
  default = [
    {
      name         = "appgw-backendpool1",
      fqdns        = ["app1.azurewebsites.net"],
      ip_addresses = null
    },
    {
      name         = "appgw-backendpool2",
      fqdns        = ["app2.azurewebsites.net"],
      ip_addresses = null
    }
  ]
```

### Block5 - path_rule
| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `name` | `string` | true | The Name of the Path Rule. |
| `paths` | `list(string)` | true | A list of Paths used in this Path Rule. |
| `backend_address_pool_name` | `string` | true | The Name of the Backend Address Pool to use for this Path Rule. |
| `backend_http_settings_name` | `string` | true | The Name of the Backend HTTP Settings Collection to use for this Path Rule. |

```
Example:
  default = [
    {
      name                       = "pathone",
      paths                      = ["/pathone*"],
      backend_address_pool_name  = "appgw-backendpool1",
      backend_http_settings_name = "appgateway-httpsettings"
    },
    {
      name                       = "pathtwo",
      paths                      = ["/pathtwo*"],
      backend_address_pool_name  = "appgw-backendpool2",
      backend_http_settings_name = "appgateway-httpsettings"
    }
  ]

Note- paths are case sensitive.
```
## Module outputs
NA

## Example - tfvars

```
azure_region = "westus"

organization_code = "ats"

environment_code  = "d"

subscription_code = "lnd2"

suffix = ["something"]

tags = {
  "CanNotDelete" = "true"
  "Owner"        = "someone"
}

appgw_rsg = "ats-lnd2-d-rsg-rgname"
appgw_location = "westus"
enable_http2 = false

appgw_sku_size = "WAF_Medium"

appgw_tier = "WAF"

appgw_capacity = 2

waf_enabled  = true

waf_configuration = null

vnet_name = "appgw-test-vnet"

subnet_name = "appgw-subnet"

vnet_rsg_name = "ats-lnd2-d-rsg-vnetname"

frontend_ip_configuration_name = "feipconfig"

private_ip_address = "10.5.0.10"

frontend_port_number = 443

ssl_certificate = {
  name = "appgwtestapp-ssl-cert",
  data = "./appgwtestapp.abc.com.pfx",
  password = "Password123"
}

probe = [
    {
      name                                      = "probe1",
      protocol                                  = "https",
      interval                                  = 30,
      timeout                                   = 30,
      unhealthy_threshold                       = 3,
      pick_host_name_from_backend_http_settings = true,
      host                                      = null
      host                                      = "",
      path                                      = "/"
    }
  ]

backendpools = [
    {
      name         = "appgwtestapp1-backendpool",
      fqdns        = ["appgwtestapp1.azurewebsites.net"],
      ip_addresses = null
    },
    {
      name         = "appgwtestapp2-backendpool",
      fqdns        = ["appgwtestapp2.azurewebsites.net"],
      ip_addresses = null
    }
  ]

http_listener_protocol = "https"

http_settings_name = "appgateway-httpsettings"

cookie_based_affinity = "Disabled"

backend_port = 443

backend_protocol = "https"

request_timeout = 20

connection_draining = false

drain_timeout = 60

hostfrombackend = true

custom_probe = "probe1"

url_path_map_name = "urlpathmap"

path_rule = [
    {
      name                       = "childpathone",
      paths                      = ["/childpathone*"],
      backend_address_pool_name  = "appgwtestapp1-backendpool",
      backend_http_settings_name = "appgateway-httpsettings"
    },
    {
      name                       = "childpathtwo",
      paths                      = ["/childpathtwo*"],
      backend_address_pool_name  = "appgwtestapp2-backendpool",
      backend_http_settings_name = "appgateway-httpsettings"
    }
  ]

routing_rule_name = "routingrule1"

routing_rule_type = "PathBasedRouting"

defaultpool = "appgwtestapp1-backendpool"
```
## License
Atos, all rights protected - 2021.
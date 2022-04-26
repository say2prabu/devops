# terraform-azurerm-applicationgateway-v2
Terraform module to deploy Azure Application Gateway. 
Application Gateway is available under a Standard_v2 SKU. Web Application Firewall (WAF) is available under a WAF_v2 SKU.

## Description
Azure Application Gateway is a web traffic load balancer that enables you to manage traffic to your web applications. 
Application layer (OSI layer 7) load balancing.
Azure Web Application Firewall (WAF) on Azure Application Gateway provides centralized protection of your web applications from common exploits and vulnerabilities.

## Module example use
Note: Root module, which may call this child module, will also have a variables.tf file. That is used to declare the variables and set any defaults.

```hcl
module "appgw" {
  source = "../../modules/terraform-azurerm-applicationgateway-v2"

  appgw_name = module.naming.application_gateway.name
  vnet_name = var.vnet_name
  vnet_rsg_name = var.vnet_rsg_name
  subnet_name = var.subnet_name
  appgw_rsg  = var.appgw_rsg
  kevault_name = var.kevault_name
  keyvault_rsg = var.keyvault_rsg
  availability_zone_for_pip = var.availability_zone_for_pip
  appgw_location = var.appgw_location
  enable_http2 = var.enable_http2
  availability_zones = var.availability_zones
  tags = var.tags
  sku = var.sku
  sku_capacity = var.sku_capacity
  autoscaling_parameters = var.autoscaling_parameters
  waf_enabled = var.waf_enabled
  file_upload_limit_mb = var.file_upload_limit_mb
  waf_mode = var.waf_mode
  max_request_body_size_kb = var.max_request_body_size_kb
  request_body_check = var.request_body_check
  rule_set_type = var.rule_set_type
  rule_set_version = var.rule_set_version
  appgw_private = var.appgw_private
  appgw_private_ip = var.appgw_private_ip
  frontend_port_settings = var.frontend_port_settings
  backendpools = var.backendpools
  appgw_probes = var.appgw_probes
  ssl_certificates_configs = var.ssl_certificates_configs
  http_listeners = var.http_listeners
  trusted_root_certificate_configs = var.trusted_root_certificate_configs
  appgw_backend_http_settings = var.appgw_backend_http_settings
  routing_rules = var.routing_rules
  url_path_map = var.url_path_map
}
```

## Module Arguments
| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `appgw_name` | `string` | true | Application Gateway Name. |
| `vnet_name` | `string` | true | Virtual Network to deploy Application Gateway. Your virtual network must be in the same location as your application gateway.. |
| `vnet_rsg_name` | `string` | true | Application Gateway Virtual Network resource group name. |
| `subnet_name` | `string` | true | Application Gateway subnet. You can select subnets that are empty or that only contain application gateways. |
| `appgw_rsg` | `string` | true | Resource Group Application Gateway is deployed in. |
| `kevault_name` | `string` | true | Azure Keyvault Name. Key vault support is limited to the v2 SKU of Application Gateway only. Azure Application Gateway currently supports only Key Vault accounts in the same subscription as the Application Gateway resource. Soft-delete feature must be enabled.. |
| `keyvault_rsg` | `string` | true | Azure Keyvault Resource Group Name.|
| `availability_zone_for_pip` | `string` | true | The availability zone to allocate the Public IP in. Possible values are Zone-Redundant, 1, 2, 3, and No-Zone. NOTE: We need to use "No-Zone" if the region doesn't support availability zones.. |
| `appgw_location` | `string` | true | Application Gateway location. |
| `enable_http2` | `bool` | true | HTTP2 enabled on the application gateway. Defaults to false. |
| `availability_zones` | `list(string)` | true | A collection of availability zones to spread the Application Gateway over. Supported only for v2 SKUs. Examples: [], ["1", "2", "3"]. |
| `tags` | `map(string)` | true | Tag value.|
| `sku` | `string` | true | The Name of the SKU to use for this Application Gateway. Possible values are Standard_v2 and WAF_v2. |
| `sku_capacity` | `number` | true | The Capacity of the SKU to use for this Application Gateway. When using a V2 SKU this value can be between 1 and 125. Optional if autoscale_configuration is set. |
| `autoscaling_parameters` | `map(string)` | true | Map containing autoscaling parameters. You provide numerical values for min_capacity and max_capacity. Must contain at least min_capacity, max_capacity will default to 5 is not provided. Example BLOCK1 provided below. |
| `waf_enabled` | `bool` | true | WAF on Application Gateway. Defaults to true.. |
| `file_upload_limit_mb` | `number` | true | The File Upload Limit in MB. Accepted values are in the range 1MB to 500MB. Defaults to 100MB. |
| `waf_mode` | `string` | true | The Web Application Firewall Mode. Possible values are Detection and Prevention. |
| `max_request_body_size_kb` | `number` | true | The Maximum Request Body Size in KB. Accepted values are in the range 1KB to 128KB. |
| `request_body_check` | `bool` | true | Is Request Body Inspection enabled? |
| `rule_set_type` | `string` | true | The Type of the Rule Set used for this Web Application Firewall. |
| `rule_set_version` | `number` | true | The Version of the Rule Set used for this Web Application Firewall. Possible values are 2.2.9, 3.0, and 3.1. |
| `appgw_private` | `bool` | true | Boolean variable to create a private Application Gateway.. |
| `appgw_private_ip` | `string` | true | Private IP for Application Gateway. Used when variable appgw_private is set to true. |
| `frontend_port_settings` | `list(map(string))` | true | Frontend port settings. Each port setting contains the name and the port for the frontend port. Example BLOCK2 provided below. |
| `backendpools` | `any` | true | List of maps including backend pool configurations. Example BLOCK3 provided below. |
| `appgw_probes` | `any` | true | Probe configuration. Example BLOCK4 provided below. |
| `ssl_certificates_configs` | `list(map(string))` | true | ssl sertificate configuration. Example BLOCK5 provided below. |
| `http_listeners` | `any` | true | Listeners configurations. A listener “listens” on a specified port and IP address for traffic that uses a specified protocol. Example BLOCK6 provided below. |
| `trusted_root_certificate_configs` | `list(map(string))` | true | List of trusted root certificates. The needed values for each trusted root certificates are 'name' and 'data' or 'filename'. This parameter is required if you are not using a trusted certificate authority (eg. selfsigned certificate). |
| `appgw_backend_http_settings` | `any` | true | Backend http settings configurations. Example BLOCK7 provided below. |
| `routing_rules` | `list(map(string))` | true | List of maps including request routing rules configurations. Example BLOCK8 provided below. |
| `url_path_map` | `any` | true | List of maps including url path map configurations. Example BLOCK9 provided below. |


### BLOCK1 - autoscaling_parameters

A autoscale_configuration block supports the following:
min_capacity - (Required) Minimum capacity for autoscaling. Accepted values are in the range 0 to 100.
max_capacity - (Optional) Maximum capacity for autoscaling. Accepted values are in the range 2 to 125.

```
Example:
autoscaling_parameters = {
  "min_capacity" = 0
  "max_capacity" = 10
}
```
### BLOCK2 - frontend_port_settings

A frontend_port block supports the following:
name - (Required) The name of the Frontend Port.
port - (Required) The port used for this Frontend Port.

```
Example:
frontend_port_settings = [
  {
    name = "frontend-https-port"
    port = 443
  }
]
```
### Block3 - backendpools

A backend_address_pool block supports the following:
name - (Required) The name of the Backend Address Pool.
fqdns - (Optional) A list of FQDN's which should be part of the Backend Address Pool.
ip_addresses - (Optional) A list of IP Addresses which should be part of the Backend Address Pool.

```
Example:
backendpools = [
  {
    name         = "appgw-afqp-backendpool",
    fqdns        = ["tst-lnd1-t-appsvc-afqp.azurewebsites.net"],
    ip_addresses = null
  },
  {
    name         = "appgw-websi-backendpool",
    fqdns        = ["tst-lnd1-t-appsvc-websi.azurewebsites.net"],
    ip_addresses = null
  }
]

To add backend pool without targets
Example:
backendpools = [
  {
    name = "backendpool"
  }
]

```
### BLOCK4 - appgw_probes

A probe block support the following:

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

"Match" sub block:
body - (Optional) A snippet from the Response Body which must be present in the Response..
status_code - (Optional) A list of allowed status codes for this Health Probe.

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

### BLOCK5 - ssl_certificates_configs

Application Gateway v2 supports integration with Key Vault for server certificates that are attached to HTTPS enabled listeners.
A ssl_certificate block supports the following:

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `name` | `string` | true | The Name of the SSL certificate that is unique within this Application Gateway |
| `data` | `string` | true | PFX certificate. |
| `password` | `string` | true | Password for the pfx file specified in data. |
| `key_vault_secret_id ` | `string` | true | Secret Id of (base-64 encoded unencrypted pfx) Secret or Certificate object stored in Azure KeyVault. You need to enable soft delete for keyvault to use this feature. Required if data is not set. |

```
Example:
ssl_certificates_configs = [
  {
    name                = "appgw-test-com-cert",
    key_vault_secret_id = "https://surbhi-keyvault.vault.azure.net/secrets/appgw-test-com-cert/4e072a7acaec418bba015363401d2545"
  }
]

Example:
ssl_certificates_configs = [
  {
    name     = "appgw-ssl-cert",
    data     = filebase64("./mycert.com.pfx"),
    password = "Password123"
  }
]

```
### BLOCK6 - http_listeners

A listener is a logical entity that checks for incoming connection requests by using the port, protocol, host, and IP address.
A http_listener block supports the following:

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `name` | `string` | true | The Name of the HTTP Listener. |
| `frontend_type` | `string` | true | Whether listener uses public or private frontend config. Possible values Public and Private. Based on this choice appropriate frontend_ip_configuration will be linked to this listener.|
| `frontend_port_name` | `string` | true | The Name of the Frontend Port use for this HTTP Listener. "Match" with the name supplied in "frontend_port_settings". |
| `protocol` | `string` | true | The Protocol to use for this HTTP Listener. Possible values are Http and Https. |
| `ssl_certificate_name` | `string` | true | The name of the associated SSL Certificate which should be used for this HTTP Listener. "Match" name with the supplied in "ssl_certificates_configs". |
| `host_name` | `string` | true | (Optional) The Hostname which should be used for this HTTP Listener. Setting this value changes Listener Type to 'Multi site'. |
| `require_sni` | `string` | true | (Optional) Should Server Name Indication be Required? Defaults to false. |
| `firewall_policy_id` | `string` | true | (Optional) The ID of the Web Application Firewall Policy which should be used for this HTTP Listener. |

```
Example:
http_listeners = [
  {
    name                 = "appgw-listener1"
    frontend_type        = "public"
    frontend_port_name   = "frontend-https-port"
    protocol             = "https"
    ssl_certificate_name = "appgw-test-com-cert"
  }
]

```
### BLOCK7 - appgw_backend_http_settings

The application gateway routes traffic to the back-end servers by using the configuration that you specify here.
A backend_http_settings block supports the following:

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `name` | `string` | true | The name of the Backend HTTP Settings Collection. |
| `path` | `string` | true | The Path which should be used as a prefix for all HTTP requests. Degaults to /. |
| `probe_name` | `string` | true | The name of an associated HTTP Probe."Match" name with that provided in "appgw_probes". |
| `affinity_cookie_name` | `string` | true | (Optional) The name of the affinity cookie. |
| `cookie_based_affinity` | `string` | true | Is Cookie-Based Affinity enabled? Possible values are Enabled and Disabled. Defaults to disabled. |
| `pick_host_name_from_backend_address` | `bool` | true | (Optional) Whether host header should be picked from the host name of the backend server. Default - false. |
| `host_name` | `string` | true | (Optional) Host header to be sent to the backend servers. Cannot be set if pick_host_name_from_backend_address is set to true. |
| `port` | `number` | true | The port which should be used for this Backend HTTP Settings Collection. |
| `protocol` | `string` | true | The Protocol which should be used. Possible values are Http and Https. |
| `request_timeout` | `number` | true | The request timeout in seconds, which must be between 1 and 86400 seconds. Default - 20. |
| `trusted_root_certificate_names` | `string` | true | (Optional) A list of trusted_root_certificate names. |

```
Example:
appgw_backend_http_settings = [
  {
    name       = "appgateway-httpsettings"
    path       = null
    probe_name = "probe1"
    port       = 443
  }
]
```
### BLOCK8 - routing_rules

Bind listener with the back-end pool and back-end HTTP settings
A request_routing_rule block supports the following:

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `name` | `string` | true | The Name of this Request Routing Rule. |
| `rule_type ` | `string` | true | The Type of Routing that should be used for this Rule. Possible values are Basic and PathBasedRouting. |
| `http_listener_name` | `string` | true | he Name of the HTTP Listener which should be used for this Routing Rule. "Match" with the name in "http_listeners". |
| `backend_address_pool_name` | `string` | true | The Name of the Backend Address Pool which should be used for this Routing Rule. "Match" with the name in "backendpools".  |
| `backend_http_settings_name` | `string` | true | The Name of the Backend HTTP Settings Collection which should be used for this Routing Rule. "Match" with the name in "appgw_backend_http_settings". |
| `url_path_map_name` | `string` | true | (Optional) The Name of the URL Path Map which should be associated with this Routing Rule. |

```
Example:
routing_rules = [
  {
    name                       = "routing-rule1"
    rule_type                  = "Basic"
    http_listener_name         = "appgw-listener1"
    backend_address_pool_name  = "backendpool"
    backend_http_settings_name = "appgateway-httpsettings"
    url_path_map_name          = null
  }
]
```
### BLOCK9 - url_path_map and path_rule

Path based rules. Route traffic from listener specified in the rule to different backend targets based on the URL path of the request.
A url_path_map block supports the following:

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `name` | `string` | true | The Name of the URL Path Map. |
| `default_backend_address_pool_name` | `string` | true | The name of the Backend Address Pool which should be used as the default pool. |
| `default_backend_http_settings_name` | `string` | true | The Name of the Default Backend HTTP Settings. |

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `name` | `string` | true | The Name of the Path Rule. |
| `paths` | `list(string)` | true | A list of Paths used in this Path Rule. |
| `backend_address_pool_name` | `string` | true | The Name of the Backend Address Pool to use for this Path Rule. |
| `backend_http_settings_name` | `string` | true | The Name of the Backend HTTP Settings Collection to use for this Path Rule. |


```
Example:
url_path_map = [
  {
    name = "name"
    default_backend_address_pool_name = "appgw-afqp-backendpool"
    default_backend_http_settings_name = "appgateway-httpsettings"
    path_rule = [
      {
        name                       = "afqp-path",
        paths                      = ["/afqp*"],
        backend_address_pool_name  = "appgw-afqp-backendpool",
        backend_http_settings_name = "appgateway-httpsettings"
      },
      {
        name                       = "websi-path",
        paths                      = ["/websi*"],
        backend_address_pool_name  = "appgw-websi-backendpool",
        backend_http_settings_name = "appgateway-httpsettings"
      }
    ]
  }
]
```
## Module outputs
NA

## Example - tfvars
```
appgw_name = "testappgwname"

vnet_name     = "testappgwvnet"
vnet_rsg_name = "testappgwrsg"
subnet_name   = "appgwsubnet"

appgw_rsg = "testappgwrsg"

kevault_name = "test-keyvault"
keyvault_rsg = "testappgwrsg"

appgw_location     = "westus"

availability_zone_for_pip = "No-Zone" #We need to use No-Zone if the region doesn't support availability zones

enable_http2       = false
availability_zones = null #[]

tags = {
  "Test" = "appgw"
}

sku = "WAF_v2"

sku_capacity = 2
autoscaling_parameters = {
  "min_capacity" = 0
  "max_capacity" = 10
}

waf_enabled              = true
file_upload_limit_mb     = 100
waf_mode                 = "Detection"
max_request_body_size_kb = 128
request_body_check       = true
rule_set_type            = "OWASP"
rule_set_version         = 3.1

appgw_private    = true
appgw_private_ip = "10.0.1.10"

frontend_port_settings = [
  {
    name = "frontend-https-port"
    port = 443
  }
]

backendpools = [
  {
    name = "backendpool"
  }
]

appgw_probes = [
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

ssl_certificates_configs = [
  {
    name                = "appgw-test-com-cert",
    key_vault_secret_id = "https://test-keyvault.vault.azure.net/secrets/appgw-test-com-cert/4e072a7acaec418bba015363401d2545"
  }
]

http_listeners = [
  {
    name                 = "appgw-listener1"
    frontend_type        = "public"
    frontend_port_name   = "frontend-https-port"
    protocol             = "https"
    ssl_certificate_name = "appgw-test-com-cert"
  }
]

trusted_root_certificate_configs = []

appgw_backend_http_settings = [
  {
    name       = "appgateway-httpsettings"
    path       = null
    probe_name = "probe1"
    port       = 443
  }
]

routing_rules = [
  {
    name                       = "routing-rule1"
    rule_type                  = "Basic"
    http_listener_name         = "appgw-listener1"
    backend_address_pool_name  = "backendpool"
    backend_http_settings_name = "appgateway-httpsettings"
    url_path_map_name          = null
  }
]
```
## License
Atos, all rights protected - 2022.
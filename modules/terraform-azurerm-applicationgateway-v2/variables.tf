variable "appgw_name" {
  description = "Application Gateway Name. The name must be between 1 and 80 characters. The name must begin with a letter or number, end with a letter, number or underscore, and may contain only letters, numbers, underscores, periods, or hyphens."
  type        = string
}

variable "vnet_name" {
  description = "Virtual Network to deploy Application Gateway. Your virtual network must be in the same location as your application gateway."
  type        = string
}

variable "vnet_rsg_name" {
  description = "Application Gateway Virtual Network resource group name."
  type        = string
}

variable "subnet_name" {
  description = "Application Gateway subnet. You can select subnets that are empty or that only contain application gateways."
  type        = string
}

variable "appgw_rsg" {
  description = "Resource Group Application Gateway is deployed in."
  type        = string
}

variable "kevault_name" {
  description = "Azure Keyvault Name. Key vault support is limited to the v2 SKU of Application Gateway only. Azure Application Gateway currently supports only Key Vault accounts in the same subscription as the Application Gateway resource. Soft-delete feature must be enabled."
  type = string
}

variable "keyvault_rsg" {
  description = "Azure Keyvault Resource Group Name."
  type = string
}

variable "availability_zone_for_pip" {
  description = "The availability zone to allocate the Public IP in. Possible values are Zone-Redundant, 1, 2, 3, and No-Zone. NOTE: We need to use No-Zone if the region doesn't support availability zones."
  type = string
}

variable "appgw_location" {
  description = "Application Gateway location."
  type        = string
}

variable "enable_http2" {
  description = "HTTP2 enabled on the application gateway. Defaults to false."
  type        = bool
  default     = false
}

variable "availability_zones" {
  description = "A collection of availability zones to spread the Application Gateway over. Supported only for v2 SKUs. Examples: [], [1, 2, 3] (Each number should be written within double quotes)."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tag value."
  type        = map(string)
}

variable "sku" {
  description = "The Name of the SKU to use for this Application Gateway. Possible values are Standard_v2 and WAF_v2."
  type = string
  default     = "WAF_v2"
}

variable "sku_capacity" {
  description = "The Capacity of the SKU to use for this Application Gateway. When using a V2 SKU this value can be between 1 and 125. Optional if autoscale_configuration is set"
  type        = number
  default     = 2
}

variable "autoscaling_parameters" {
  type        = map(string)
  description = "Map containing autoscaling parameters. You provide numerical values for min_capacity and max_capacity. Must contain at least min_capacity, max_capacity will default to 5 is not provided."
  default     = null
}

variable "waf_enabled" {
  description = "WAF on Application Gateway. Defaults to true."
  type        = bool
  default     = true
}

variable "file_upload_limit_mb" {
  description = " The File Upload Limit in MB. Accepted values are in the range 1MB to 500MB. Defaults to 100MB."
  type        = number
  default     = 100
}

variable "waf_mode" {
  description = "The Web Application Firewall Mode. Possible values are Detection and Prevention."
  type        = string
  default     = "Detection"
}

variable "max_request_body_size_kb" {
  description = "The Maximum Request Body Size in KB. Accepted values are in the range 1KB to 128KB."
  type        = number
  default     = 128
}

variable "request_body_check" {
  description = "Is Request Body Inspection enabled?"
  type        = bool
  default     = true
}

variable "rule_set_type" {
  description = "The Type of the Rule Set used for this Web Application Firewall."
  type        = string
  default     = "OWASP"
}

variable "rule_set_version" {
  description = "The Version of the Rule Set used for this Web Application Firewall. Possible values are 2.2.9, 3.0, and 3.1."
  type        = number
  default     = 3.1
}

variable "appgw_private" {
  description = "Boolean variable to create a private Application Gateway."
  type        = bool
  default     = false
}

variable "appgw_private_ip" {
  description = "Private IP for Application Gateway. Used when variable `appgw_private` is set to `true`."
  type        = string
  default     = null
}

variable "frontend_port_settings" {
  description = "Frontend port settings. Each port setting contains the name and the port for the frontend port."
  type        = list(map(string))
}

variable "backendpools" {
  description = "List of maps including backend pool configurations"
  type        = any
}

variable "appgw_probes" {
  description = "Probe configuration."
  type        = any
  default     = []
}

variable "ssl_certificates_configs" {
  description = <<EOD
List of maps including ssl certificates configurations.
The path to a base-64 encoded certificate is expected in the 'data' parameter:
```
data = filebase64("./file_path")
```
EOD
  type        = list(map(string))
  default     = []
}

variable "http_listeners" {
  description = "Listeners configurations. A listener “listens” on a specified port and IP address for traffic that uses a specified protocol."
  type        = any
}

variable "trusted_root_certificate_configs" {
  description = "List of trusted root certificates. The needed values for each trusted root certificates are 'name' and 'data' or 'filename'. This parameter is required if you are not using a trusted certificate authority (eg. selfsigned certificate)"
  type        = list(map(string))
  default     = []
}

variable "appgw_backend_http_settings" {
  description = "Backend http settings configurations"
  type        = any
}

variable "routing_rules" {
  description = "List of maps including request routing rules configurations"
  type        = list(map(string))
}

variable "url_path_map" {
  description = "List of maps including url path map configurations"
  type        = any
  default     = []
}
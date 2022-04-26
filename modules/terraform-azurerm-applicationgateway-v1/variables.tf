variable "appgw_name" {
  description = "Application Gateway Name."
  type        = string
}

variable "appgw_rsg" {
  description = "Resource Group Application Gateway is deployed in."
  type        = string
}

variable "appgw_location" {
  description = "Application Gateway location."
  type        = string
}

variable "enable_http2" {
  description = "HTTP2 enabled on the application gateway. Defaults to false."
  type        = bool
  default = false
}

variable "tags" {
  description = "Tag value."
  type        = map(string)
}

variable "appgw_sku_size" {
  description = "Application Gateway SKU size. Please choose between: Standard_Small, Standard_Medium, Standard_Large, WAF_Medium and WAF_Large."
  type        = string
}

variable "appgw_tier" {
  description = "Application Gateway SKU tier. Please choose between: Standard and WAF."
  type        = string
}

variable "appgw_capacity" {
  description = "The Capacity of the SKU to use for this Application Gateway. When using a V1 SKU this value must be between 1 and 32."
  type        = number
}

variable "waf_enabled" {
  description = "WAF on Application Gateway. Defaults to true."
  type        = bool
  default = true
}

variable "waf_configuration" {
  description = "Configuration block for WAF. Defaults to null, which configures WAF with these settings: Detection, OWASP, 3.0, 100, 128. For details please refer README.md. "
  type = object({
    firewall_mode            = string
    rule_set_type            = string
    rule_set_version         = string
    file_upload_limit_mb     = number
    max_request_body_size_kb = number
  })
  default = null
}
variable "frontend_ip_configuration_name" {
  description = "The name of the Frontend IP Configuration."
  type        = string
}

variable "private_ip_address" {
  description = "The Private IP Address to use for the Application Gateway. Pick one from the subnet this Application Gateway is deployed in. Static allocation."
  type        = string
}

variable "frontend_port_number" {
  description = "Enter a frontend port number for the listener. You can use well known ports, such as port 80 and 443, or any port ranging from 1 to 65502 (v1 SKU) or 1 to 65199 (v2 SKU)."
  type        = number
}

variable "ssl_certificate" {
  description = "SSL certficate configuration. Please read README.md for detailed explanation."
  type = object({
    name     = string,
    data     = string,
    password = string
  })
}

variable "probe" {
  description = "Probe configuration. Please read README.md for detailed explanation."
  type = list(object({
    name                                      = string,
    protocol                                  = string,
    interval                                  = number,
    timeout                                   = number,
    unhealthy_threshold                       = number,
    pick_host_name_from_backend_http_settings = bool,
    host                                      = string,
    path                                      = string
  }))
}

variable "backendpools" {
  description = "Backend Pools. Supply a name for the pool and a list of fqdn's/IP's which should be part of the backend address pool. Example: example..azurewebsites.net"
  type = list(object({
    name         = string,
    fqdns        = list(string),
    ip_addresses = list(string)
  }))
}

variable "http_listener_protocol" {
  description = "The Protocol to use for HTTP Listener. Possible values are Http and Https."
  type        = string
}

variable "http_settings_name" {
  description = "Http Settings: name - between 1 and 80 characters. Must begin with a letter or number, end with a letter, number or underscore, and may contain only letters, numbers, underscores, periods, or hyphens."
  type        = string
}

variable "cookie_based_affinity" {
  description = "Http Settings: Is Cookie-Based Affinity enabled? Possible values are Enabled and Disabled."
  type        = string
  default     = "Disabled"
}

variable "backend_port" {
  description = "Http Settings: The port which should be used for this Backend HTTP Settings Collection (80, 443)."
  type        = number
}

variable "backend_protocol" {
  description = "Http Settings: The Protocol which should be used. Possible values are Http and Https."
  type        = string
}

variable "request_timeout" {
  description = "Http Settings: The request timeout is the number of seconds that the application gateway will wait to receive a response from the backend pool before it returns a “connection timed out” error message - - between 1 and 86400 seconds."
  type        = number
}

variable "connection_draining" {
  description = "Http Settings: If connection draining is enabled or not. Defaults to false."
  type        = bool
  default     = false
}

variable "drain_timeout" {
  description = "Http Settings: The number of seconds connection draining is active. Acceptable values are from 1 second to 3600 seconds. Specify this value even if connection_draining is set to false."
  type        = number
}

variable "hostfrombackend" {
  description = "Http Settings: Pick host name from backend target. Defaults to true."
  type        = bool
  default = true
}

variable "custom_probe" {
  description = "Http Settings: The name of an associated custom Probe."
  type        = string
}

variable "path_rule" {
  description = "Path based rules. Forms a part of URL path map."
  type = list(object({
    name                       = string,
    paths                      = list(string),
    backend_address_pool_name  = string,
    backend_http_settings_name = string
  }))
}

variable "routing_rule_name" {
  description = "The Name of this Request Routing Rule."
  type        = string
}

variable "routing_rule_type" {
  description = "The Type of Routing that should be used for this Rule. Possible values are Basic and PathBasedRouting."
  type        = string
}

variable "defaultpool" {
  description = "Default pool name to be used in Request Routing Rule."
  type        = string
}

variable "url_path_map_name" {
  description = "The Name of the URL Path Map which should be associated with this Routing Rule."
  type        = string
}
variable "subnet_id" {
  type        = string
  description = "The ID of the Subnet from which Private IP Addresses will be allocated."
}
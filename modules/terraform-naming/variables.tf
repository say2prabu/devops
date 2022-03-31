
variable "organization-code" {
  type        = string
  description = "A three character Atos code according to Atos DCS naming convention indicating which organization we are deploying this automation for. When for Atos use: ats"
}

variable "environment-code" {
  type        = string
  description = "A one character Atos code according to Atos DCS naming convention to indicate which environment type will be deployed to. Example 'd' for Development, 't' for Test etc."
}

variable "subscription-code" {
  type        = string
  description = "A four character Atos code according to Atos DCS naming convention to indicate which subscription we are deploying the automation to. Example 'mgmt' for management, 'lnd1' for the 1st landingzone."
}

variable "suffix" {
  type        = list(string)
  description = "It is recommended that you specify a suffix for consistency. please use only lowercase characters."
  default     = [""]
}

variable "unique-seed" {
  type        = string
  description = "Custom value for the random characters to be used"
  default     = ""
}

variable "unique-length" {
  type        = number
  description = "Max length of the uniqueness suffix to be added"
  default     = 6
}

variable "unique-include-numbers" {
  type        = bool
  description = "If you want to include numbers in the unique generation"
  default     = true
}

variable "azure_region" {
  type        = string
  description = "region code variable"
  default     = "westeurope"
}

variable "azure-regions" {
  type        = map(any)
  description = "A four character Atos code according to Atos DCS naming convention to indicate Azure location/region."
  default = {
    "australiacentral"   = "auce"
    "australiacentral2"  = "auc2"
    "australiaeast"      = "auea"
    "australiasoutheast" = "ause"
    "brazilsouth"        = "brso"
    "brazilsoutheast"    = "brse"
    "canadacentral"      = "cace"
    "canadaeast"         = "caea"
    "centralindia"       = "ince"
    "centralus"          = "usce"
    "eastasia"           = "asea"
    "eastus"             = "usea"
    "eastus2"            = "use2"
    "francecentral"      = "eufc"
    "francesouth"        = "frso"
    "germanynorth"       = "eugn"
    "germanywestcentral" = "gewc"
    "japaneast"          = "jpea"
    "japanwest"          = "jpwe"
    "koreacentral"       = "koce"
    "koreasouth"         = "koso"
    "northcentralus"     = "usnc"
    "northeurope"        = "eune"
    "norwayeast"         = "nwea"
    "norwaywest"         = "nwwe"
    "southafricanorth"   = "sano"
    "southafricawest"    = "sawe"
    "southcentralus"     = "ussc"
    "southeastasia"      = "asse"
    "southindia"         = "inso"
    "switzerlandnorth"   = "swno"
    "switzerlandwest"    = "swwe"
    "uaecentral"         = "uace"
    "uaenorth"           = "uano"
    "uksouth"            = "ukso"
    "ukwest"             = "ukwe"
    "westcentralus"      = "uswc"
    "westeurope"         = "euwe"
    "westindia"          = "inwe"
    "westus"             = "uswe"
    "westus2"            = "usw2"
    "westus3"            = "usw3"
  }
}
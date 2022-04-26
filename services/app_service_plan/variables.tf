variable "azure_region" {
    type=string
}

variable "organization-code" {
    type=string
}

variable "subscription-code" {
    type=string
}

variable "environment-code" {
  type=string
}

variable "service_plan_name" {
  type=string
}

variable "service_plan_definition" {
 type = object({
    kind             = string
    size             = string
    tier             = string
    per_site_scaling = bool
  })
}

variable "tags" {
  type = map(string)
}
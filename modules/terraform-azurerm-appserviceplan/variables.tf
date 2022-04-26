variable "appsvcplan_name" {
  type = string
}
variable "tags" {
  type = map(string)
}
variable "resource_group_name" {
  type        = string
  description = "A container that holds related resources for an Azure solution"
}
variable "location" {
  type        = string
  description = "The location/region to keep all your network resources. To get the list of all locations with table format from azure cli, run 'az account list-locations -o table'"
}
variable "service_plan" {
  description = "Definition of the dedicated plan to use"
  type = object({
    kind             = string
    size             = string
    tier             = string
    per_site_scaling = bool
  })
}

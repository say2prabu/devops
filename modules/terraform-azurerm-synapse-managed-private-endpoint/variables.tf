variable "name" {
  type        = string
  description = "Specifies the name which should be used for this Managed Private Endpoint."
}
variable "synapse_workspace_id" {
  type        = string
  description = "The ID of the Synapse Workspace on which to create the Managed Private Endpoint."
}
variable "target_resource_id" {
  type        = string
  description = "The ID of the Private Link Enabled Remote Resource which this Synapse Private Endpoint should be connected to."
}
variable "subresource_name" {
  type        = string
  description = "Specifies the sub resource name which the Synapse Private Endpoint is able to connect to."
}

variable "azure_region" {
  type = string
}

variable "organization-code" {
  type = string
}

variable "environment-code" {
  type = string
}

variable "subscription-code" {
  type = string
}

variable "suffix" {
  type = list(string)
}

variable "rsg_location" {
  type = string
}

variable "client_id" {
  type = string
}

variable "client_secret" {
  type = string
}

variable "subscription_id" {
  type = string
}

variable "tenant_id" {
  type = string
}

variable "tags" {
  type = map
  default = {}
}
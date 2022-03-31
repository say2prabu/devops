variable "client_id" {
  type = string
}

variable "client_secret" {
  type = string
}

variable "sub_id" {
  type = string
}

variable "tenant_id" {
  type = string
}


terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
 #     version = "=2.46.0"
      version = "=3.0.2"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}

  subscription_id = var.sub_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

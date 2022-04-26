# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.76.0"
    }
  }

  backend "azurerm"{}
}

provider "azurerm" {
  features {}
  
  client_id = var.client_id
  client_secret = var.client_secret
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}
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

variable "rg_name" {
  type = string
}

variable "rg_location" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "vnet_rg_name" {
  type = string
}

variable "subnet_name" {
  type = string
}

variable "vm_size" {
  type = string
  default = "Standard_DS1_v2"
}

## variables for logging into the vm
variable "admin_username" {
  type = string
  default = "adminuser"
}

variable "disable_password_authentication" {
  type = bool
  default = true
}

variable "sshkey_name" {
  type = string
  default = "sie-lan-t-ssh-key"
  description = "sSH Key name"
}

variable "sshkey_rg_name" {
  type = string
  default = "sie-lan1-t-rsg-vm"
  description = "sSH Key Resouce Group name"
}

variable "kv_name" {
  type = string
  default = "sie-lz01-t-kv"
  description = "Key Vault name to store vm password"
  
}

variable "kv_rg_name" {
  type = string
  default = "sie-lz01-t-rsg-encrypt"
  description = "Key Vault resource group name to store vm password"
}



#### variables for setting the image and storage configuratio

variable "use_custom_image" {
  type = bool
  default = true
  description = "Specify this for using Custom / Hardened Image"
}

variable "custom_image_id" {
  type = string
  default = "/subscriptions/8d8f94b2-aacb-415c-bc81-f696f9c56862/resourceGroups/sie-mgmt-t-rsg-image/providers/Microsoft.Compute/galleries/sie_mgmt_t_SharedImageGallery/images/Redhatv2/versions/1.1.0"
}


variable "publisher" {
  type = string
  default = "Canonical"
}

variable "offer" {
  type = string
  default = "0001-com-ubuntu-server-focal"
}

variable "sku" {
  type = string
  default = "20_04-lts-gen2"
}

variable "image_version" {
  type = string
  default = "latest"
}


### variables for the os disk
variable "caching" {
  type = string
  default = "ReadWrite"
}

variable "storage_account_type" {
  type = string
  default = "Standard_LRS"
}


variable "tags" {
  type = map
  default = {}
}


#variable "boot_diagnostics_sa_type" {
#  description = "Storage account type for boot diagnostics"
#  default     = "Standard_LRS"
#}

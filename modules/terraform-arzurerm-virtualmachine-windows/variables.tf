variable "rsg_loc" {
  type = string
}

variable "rsg_name" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "subnet_name" {
  type = string
}

variable "vm_size" {
  type = string
  default = "Standard_DS1_v2"
}

variable "vm_name" {
  type = string
}

variable "nic_name" {
  type = string
  default = "default-nic"
}


## variables for logging into the vm
variable "admin_username" {
  type = string
  default = "adminuser"
}

variable "admin_password" {
  type = string
  default = "password123!"
}


#### variables for setting the image and storage configuratio
variable "publisher" {
  type = string
  default = "MicrosoftWindowsServer"
}

variable "offer" {
  type = string
  default = "WindowsServer"
}

variable "sku" {
  type = string
  default = "2016-Datacenter"
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
}
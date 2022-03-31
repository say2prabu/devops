variable "rsg_loc" {
  type = string
}

variable "rsg_name" {
  type = string
}

variable "vnet_name" {
  type = string
}


variable "vnet_rsg_name" {
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
}

variable "ssh_key" {
  type = string
  default = ""
}

variable "admin_password" {
  type = string
}

variable "disable_password_authentication" {
  type = bool
  default = true
}


variable "use_custom_image" {
  type = bool
  default = true
}

variable "custom_image_id" {
  type = string
  default = ""
}

#### variables for setting the image and storage configuration
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
}

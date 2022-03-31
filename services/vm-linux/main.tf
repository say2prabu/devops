module "naming" {
  source = "../../modules/terraform-naming"

  azure_region      = var.azure_region
  organization-code = var.organization-code
  environment-code = var.environment-code
  subscription-code = var.subscription-code
  suffix            = ["not_used"]
}
  
 
#resource "azurerm_storage_account" "main" {
#  name                     = "${module.naming.virtual_machine_linux.name}-BDStorage"
#  resource_group_name      = var.rg_name
#  location                 = var.rg_location
#  account_tier             = "${element(split("_", var.boot_diagnostics_sa_type),0)}"
#  account_replication_type = "${element(split("_", var.boot_diagnostics_sa_type),1)}"
#}
  
  
resource "random_password" "vmpassword" {
  length = 20
  min_upper = 2
  min_lower = 2
  min_numeric = 2
  min_special = 2
}


data "azurerm_key_vault" "main" {
  name                = var.kv_name
  resource_group_name = var.kv_rg_name
}

  
resource "azurerm_key_vault_secret" "vmpassword" {
  name         = "${module.naming.virtual_machine_linux.name}-vmpass"
  value        = random_password.vmpassword.result
  key_vault_id = data.azurerm_key_vault.main.id
}

  
data "azurerm_ssh_public_key" "main" {
  name                = var.sshkey_name
  resource_group_name = var.sshkey_rg_name
}
  
module "virtual-machine" {
    source = "../../modules/terraform-arzurerm-virtualmachine-linux"

    # variables for the rsg and vnet/subnet
    rsg_loc = var.rg_location
    rsg_name = var.rg_name
    # variables for the nic
    nic_name = "${module.naming.virtual_machine_linux.name}-nic"

    # variables for the vm
    vm_name = module.naming.virtual_machine_linux.name
    vm_size = var.vm_size
    admin_username = var.admin_username
    # ssh_key = data.azurerm_ssh_public_key.main.public_key
    ssh_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDtl4KNK6MmYtJyVL/0NEoElgSBXRMwumwfOY4VmmkR4YGOWMU58qfVgc1hQ9ntAwoOuNhsjX01KIhdAIK+zQa6vS8fwAU4cXIPYiz59705wTgKKDjh1/wecj+kLFSWeKdT94TQRqoxY8urEguIKikITy3yx4W0p9Me/WGN756rJyVilkxXyc/IAaDpQ+LNPKqpueeQ9ZLpWwmLr39LgxzgRNlx+cvS9ZHGJmwTBFywKVmjOhG/bHs0NbvBgkOjRXByygfhOMtQKJ7xG4g8qCs4kXv7wZuVo7aeq4fP175sUtSrQRPpvbaWexZVaptbonrwv8Yp6YArK++rQkBeuz3hFwiAwX77NzFeBvzr8Api7OF0WK7xEBcLcgph8VS/RGf4tmc5BTqreTImS/XFSAzGrrtdOFuW7BD8WGaQMcH+Jsss6pnMzg9VQN7YDyqG7wLZvlrnwI1/Ls3LgofyAI8KDzuLAEHsfJnjm1NiXslaG9H2ddDzqRityermTUfZDCU= generated-by-azure"
    disable_password_authentication = var.disable_password_authentication
    admin_password = random_password.vmpassword.result
    vnet_rsg_name = var.vnet_rg_name
    vnet_name = var.vnet_name
    subnet_name = var.subnet_name
    # variables for the image used by the vm
    use_custom_image = var.use_custom_image
    custom_image_id = var.custom_image_id
    publisher = var.publisher
    offer = var.offer
    sku = var.sku
    image_version = var.image_version

    # variables for the os disk used by the vm
    caching  = var.caching
    storage_account_type = var.storage_account_type
      
    # boot_diagnostics {
    # enabled = "true"
    # storage_account_uri = ""
    # }

    # set the tags
    tags = var.tags
}

  
  
  

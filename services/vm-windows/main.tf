module "naming" {
  source = "../../modules/terraform-naming"

  azure_region      = var.azure_region
  organization-code = var.organization-code
  environment-code = var.environment-code
  subscription-code = var.subscription-code
  suffix            = ["not_used"]
}


module "virtual-machine" {
    source = "../../modules/terraform-arzurerm-virtualmachine-windows"

    # variables for the rsg and vnet/subnet
    rsg_loc = var.rg_location
    rsg_name = var.rg_name
    vnet_name    = var.vnet_name
    subnet_name  = var.subnet_name


    # variables for the nic
    nic_name = "${module.naming.virtual_machine_windows.name}-nic"

    # variables for the vm
    vm_name = module.naming.virtual_machine_windows.name
    vm_size = var.vm_size
    admin_username = var.admin_username
    admin_password = var.admin_password

    # variables for the image used by the vm
    publisher = var.publisher
    offer = var.offer
    sku = var.sku
    image_version = var.image_version

    # variables for the os disk used by the vm
    caching  = var.caching
    storage_account_type = var.storage_account_type

    # set the tags
    tags = var.tags
}

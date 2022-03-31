data "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.vnet_rsg_name
}

data "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_virtual_network.vnet.resource_group_name
}

resource "azurerm_network_interface" "main" {
  name                = var.nic_name
  location            = var.rsg_loc
  resource_group_name = var.rsg_name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = data.azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}


# Create storage account for boot diagnostics
resource "azurerm_storage_account" "BDstorageaccount" {
  name                     = "${var.vm_name}bdsa"
  location                 = var.rsg_loc
  resource_group_name      = var.rsg_name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}


# allows a user to use an sshkey instead of an admin password
resource "azurerm_linux_virtual_machine" "main" {
  #check what password they want
  count = var.disable_password_authentication ? 1 : 0
  
  depends_on = [
    azurerm_network_interface.main,
    azurerm_storage_account.BDstorageaccount
  ]

  name                  = var.vm_name
  location              = var.rsg_loc
  resource_group_name   = var.rsg_name
  network_interface_ids = [azurerm_network_interface.main.id]
  size                  = var.vm_size
  admin_username        = var.admin_username
  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_key
  }

  source_image_id = var.custom_image_id
 
    
  os_disk {
    caching              = var.caching
    storage_account_type = var.storage_account_type
  }

  boot_diagnostics {
    # enabled = "true"
    storage_account_uri = azurerm_storage_account.BDstorageaccount.primary_blob_endpoint
   }
  
  tags = local.concat_tags
}

# allows the user to use a password to login, instead of an ssh key
resource "azurerm_linux_virtual_machine" "admin-password" {
  #check what password they want
  count = var.disable_password_authentication ? 0 : 1
  
  depends_on = [
    azurerm_network_interface.main,
    azurerm_storage_account.BDstorageaccount
  ]
  name                            = var.vm_name
  location                        = var.rsg_loc
  resource_group_name             = var.rsg_name
  network_interface_ids           = [azurerm_network_interface.main.id]
  size                            = var.vm_size
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  disable_password_authentication = var.disable_password_authentication

  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = var.image_version
  }

  os_disk {
    caching              = var.caching
    storage_account_type = var.storage_account_type
  }

  boot_diagnostics {
  storage_account_uri = azurerm_storage_account.BDstorageaccount.primary_blob_endpoint
  }
  
  tags = local.concat_tags
}

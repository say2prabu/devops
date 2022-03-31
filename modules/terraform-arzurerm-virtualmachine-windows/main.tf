data "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.rsg_name
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

resource "azurerm_windows_virtual_machine" "example" {
  depends_on = [
    azurerm_network_interface.main
  ]
  name                            = var.vm_name
  location                        = var.rsg_loc
  resource_group_name             = var.rsg_name
  network_interface_ids           = [azurerm_network_interface.main.id]
  size                            = var.vm_size
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password

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

  tags = local.concat_tags
}
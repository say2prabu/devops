resource "azurerm_sql_managed_instance" "msqli" {
  name                         = var.name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password
  license_type                 = var.license_type
  subnet_id                    = var.subnet_id
  sku_name                     = var.sku_name
  vcores                       = var.vcores
  storage_size_in_gb           = var.storage_size_in_gb
  timezone_id                  = var.timezone_id
  collation                    = var.collation
  proxy_override               = var.proxy_override
  tags                         = var.tags
  timeouts {
    create = "360h"
  }
}

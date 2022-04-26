resource "azurerm_data_factory" "main" {
  name                   = var.datafactory_name
  location               = var.location
  resource_group_name    = var.resource_group_name
  tags                   = var.tags
  public_network_enabled = true

}

resource "azurerm_data_factory_integration_runtime_self_hosted" "main" {
  for_each            = var.adf_ir_name
  name                = each.value
  resource_group_name = var.resource_group_name
  data_factory_name   = azurerm_data_factory.main.name
}

resource "azurerm_data_factory_linked_service_sftp" "main" {
  for_each            = var.adf_linked_services_sftp
  name                = each.value.sftp_name
  resource_group_name = var.resource_group_name
  data_factory_name   = azurerm_data_factory.main.name
  authentication_type = each.value.authentication_type
  host                = each.value.host
  port                = each.value.port
  username            = each.value.username
  password            = each.value.password
}

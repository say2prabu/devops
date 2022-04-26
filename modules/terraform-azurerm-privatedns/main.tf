resource "azurerm_private_dns_zone" "private_dns_zone" {
  for_each            = var.dns_zone_name
  name                = each.value.name
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "private_dns_zone_vnet_link" {
  for_each              = var.dns_zone_name
  name                  = "vnet-link-${each.value.name}"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone[each.key].name
  virtual_network_id    = var.virtual_network_id
  registration_enabled  = var.registration_enabled
}

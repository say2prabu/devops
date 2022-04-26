resource "azurerm_lb" "loadbalancer" {
  name                = var.name
  sku                 = var.sku
  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "frontend_ip_configuration" {
    for_each = var.lb_private_ip 
    content {
      name                          = frontend_ip_configuration.value["name"]
      subnet_id                     = frontend_ip_configuration.value["subnet_id"]
      private_ip_address            = frontend_ip_configuration.value["private_ip_address"]
      private_ip_address_allocation = frontend_ip_configuration.value["private_ip_address_allocation"]

    }
  }
}

resource "azurerm_lb_backend_address_pool" "lb_backend_addresspool" {
  for_each        = var.backend_pool
  loadbalancer_id = azurerm_lb.loadbalancer.id
  name            = each.key
  depends_on = [
    azurerm_lb.loadbalancer
  ]
}

resource "azurerm_lb_backend_address_pool_address" "lb_backend_addresspool_address" {
  for_each = var.backend_pool_address
  name     = each.key
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb_backend_addresspool[each.value.backend_pool_name].id #goes towards backend pool having only one value so it works
  virtual_network_id      = each.value.vnet_id
  ip_address              = each.value.backend_ip

}

resource "azurerm_lb_probe" "lb_probe" {
  for_each            = var.lb_probe
  #resource_group_name = var.resource_group_name
  loadbalancer_id     = azurerm_lb.loadbalancer.id
  name                = each.key
  port                = each.value.port
  protocol            = each.value.protocol
  interval_in_seconds = each.value.interval_in_seconds
  number_of_probes    = each.value.number_of_probes
  depends_on = [
    azurerm_lb.loadbalancer
  ]
}

resource "azurerm_lb_rule" "lb_rule" {
  for_each                       = var.lb_rule
  #resource_group_name            = var.resource_group_name
  loadbalancer_id                = azurerm_lb.loadbalancer.id
  name                           = each.key
  protocol                       = each.value.protocol
  frontend_port                  = each.value.frontend_port
  backend_port                   = each.value.backend_port
  frontend_ip_configuration_name = each.value.frontend_ip_name
  probe_id                       = azurerm_lb_probe.lb_probe[each.value.lb_probe_name].id
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.lb_backend_addresspool[each.value.lb_backend_pool_name].id]
  disable_outbound_snat          = each.value.disable_snat
  enable_tcp_reset               = each.value.enable_tcp_reset
  idle_timeout_in_minutes        = each.value.idle_timeout
  enable_floating_ip             = each.value.enable_floating_ip
}
resource "azurerm_lb_nat_rule" "lb_nat_rule" {
  for_each                       = var.lb_nat_rule
  name                           = each.key
  resource_group_name            = var.resource_group_name
  loadbalancer_id                = azurerm_lb.loadbalancer.id
  protocol                       = each.value.lb_nat_rule_protocol
  frontend_port                  = each.value.lb_nat_rule_front_port
  idle_timeout_in_minutes        = each.value.idle_timeout_in_minutes
  backend_port                   = each.value.lb_nat_rule_back_port
  frontend_ip_configuration_name = each.value.frontend_ip_name
  enable_tcp_reset               = each.value.enable_tcp_reset
  enable_floating_ip             = each.value.lb_nat_rule_enable_floating_ip
}


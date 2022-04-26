resource "azurerm_public_ip" "lb_pip" {
  for_each                = var.lb_pip
  name                    = each.key
  location                = var.location
  resource_group_name     = var.resource_group_name
  allocation_method       = each.value.allocation_method
  sku                     = "Standard"
  idle_timeout_in_minutes = each.value.idle_timeout_in_minutes
  tags                    = var.tags
}
resource "azurerm_lb" "loadbalancer" {
  name = var.name
  sku  = var.sku
  #  sku_tier            = var.sku_tier
  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "frontend_ip_configuration" {
    for_each = azurerm_public_ip.lb_pip
    iterator = pip
    content {
      name                 = pip.value.name
      public_ip_address_id = pip.value.id
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
  #for_each = azurerm_lb_backend_address_pool.lb_backend_addresspool
  name                    = each.key
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb_backend_addresspool[each.value.backend_pool_name].id
  #backend_address_pool_id = each.value.id
  virtual_network_id = each.value.vnet_id
  ip_address         = each.value.backend_ip

}

resource "azurerm_lb_probe" "lb_probe" {
  for_each = var.lb_probe
  #  resource_group_name = var.resource_group_name
  loadbalancer_id     = azurerm_lb.loadbalancer.id
  name                = each.key
  port                = each.value.port
#  protocol            = each.value.protocol
#  request_path        = each.value.request_path
  interval_in_seconds = each.value.interval_in_seconds
  number_of_probes    = each.value.number_of_probes
  depends_on = [
    azurerm_lb.loadbalancer
  ]
}

resource "azurerm_lb_rule" "lb_rule" {
  for_each = var.lb_rule
  #  resource_group_name            = var.resource_group_name
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
  backend_port                   = each.value.lb_nat_rule_back_port
  frontend_ip_configuration_name = each.value.frontend_ip_name
  idle_timeout_in_minutes        = each.value.idle_timeout_in_minutes
  enable_floating_ip             = each.value.lb_nat_rule_enable_floating_ip
}
resource "azurerm_lb_outbound_rule" "lb_outbound_rule" {
  for_each = var.lb_outbound_rule
  #  resource_group_name      = var.resource_group_name
  loadbalancer_id          = azurerm_lb.loadbalancer.id
  name                     = each.key
  protocol                 = each.value.lb_outbound_rule_protocol
  backend_address_pool_id  = azurerm_lb_backend_address_pool.lb_backend_addresspool[each.value.lb_backend_pool_name].id
  allocated_outbound_ports = each.value.lb_outbound_rule_allocated_ports
  idle_timeout_in_minutes  = each.value.lb_outbound_rule_idle_timeout

  frontend_ip_configuration {
    name = "pip1"
  }

  # dynamic "frontend_ip_configuration" {
  #   for_each = each.value.pip_name
  #   iterator = ip
  #   content {
  #     name = ip.value
  #   }
  # }
}

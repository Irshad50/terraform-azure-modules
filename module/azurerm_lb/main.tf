resource "azurerm_lb" "lb" {
  for_each            = var.lb
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  sku                 = lookup(each.value, "sku", "Standard")

  frontend_ip_configuration {
    name                 = each.value.frontend_ip_name
    public_ip_address_id = lookup(each.value, "public_ip_id", null)
    subnet_id            = lookup(each.value, "subnet_id", null)
  }
}

resource "azurerm_lb_backend_address_pool" "backend_pool" {
  for_each        = var.lb
  name            = "${each.value.name}-backend-pool"
  loadbalancer_id = azurerm_lb.lb[each.key].id
}

resource "azurerm_lb_probe" "health_probe" {
  for_each        = var.lb
  name            = "${each.value.name}-health-probe"
  loadbalancer_id = azurerm_lb.lb[each.key].id
  protocol        = lookup(each.value, "probe_protocol", "Tcp")
  port            = lookup(each.value, "probe_port", 80)
}

resource "azurerm_lb_rule" "lb_rule" {
  for_each                       = var.lb
  name                           = "${each.value.name}-rule"
  loadbalancer_id                = azurerm_lb.lb[each.key].id
  protocol                       = lookup(each.value, "rule_protocol", "Tcp")
  frontend_port                  = lookup(each.value, "frontend_port", 80)
  backend_port                   = lookup(each.value, "backend_port", 80)
  frontend_ip_configuration_name = each.value.frontend_ip_name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.backend_pool[each.key].id]
  probe_id                       = azurerm_lb_probe.health_probe[each.key].id
}

resource "azurerm_network_interface_backend_address_pool_association" "nic_assoc" {
  for_each                = var.lb_nic_associations
  network_interface_id    = each.value.nic_id
  ip_configuration_name   = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.backend_pool[each.value.lb_key].id
}

output "lb_id" {
  value = {
    for k, v in azurerm_lb.lb :
    k => v.id
  }
}

output "backend_pool_id" {
  value = {
    for k, v in azurerm_lb_backend_address_pool.backend_pool :
    k => v.id
  }
}

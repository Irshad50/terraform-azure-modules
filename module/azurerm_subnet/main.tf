resource "azurerm_subnet" "subnet" {

  for_each = var.subnet

  name                 = each.value.name
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.vnet_name
  address_prefixes     = each.value.address_prefixes
}
output "subnet_id" {
  value = {
    for k, v in azurerm_subnet.subnet :
    k => v.id
  }
}

resource "azurerm_public_ip" "pip" {

  for_each = var.public_ips

  name = each.value.name

  resource_group_name = each.value.resource_group_name

  location = each.value.location

  allocation_method = "Static"
}
output "public_ip_id" {
  value = {
    for k, v in azurerm_public_ip.pip :
    k => v.id
  }
}
resource "azurerm_resource_group" "aq" {
  for_each = var.qa1
  name     = each.value.name
  location = each.value.location
}
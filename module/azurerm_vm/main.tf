resource "azurerm_linux_virtual_machine" "vm" {

  for_each = var.vm

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  size                            = each.value.size
  admin_username                  = each.value.adminuser
  admin_password                  = each.value.password
  disable_password_authentication = false

  network_interface_ids = [each.value.nic_id]

  os_disk {

    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"

  }

  source_image_reference {

    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"

  }

}

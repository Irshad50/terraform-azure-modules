module "resource_group" {
  source = "../../module/azurerm_resource_group"
    qa1 = var.qa1
}

module "vnet" {
  depends_on = [module.resource_group]
  source = "../../module/azurerm_virtual_network"
  vnet = var.vnet
}

module "subnet" {
  depends_on = [module.resource_group, module.vnet]
  source = "../../module/azurerm_subnet"
  subnet = var.subnet
}
module "pip" {
  depends_on = [module.resource_group, module.vnet, module.subnet]
  source = "../../module/azurerm_pip"
  public_ips = var.public_ips
}
module "bastion" {
  depends_on = [module.resource_group, module.vnet, module.subnet, module.pip]
  source = "../../module/azurerm_bastion"
  bastions = {

    for k, v in var.bastions :

    k => merge(v, {

      subnet_id = module.subnet.subnet_id[v.subnet_key]

      public_ip_address_id = module.pip.public_ip_id[v.public_key]

    })
  }
}
module "nsg" {
 depends_on = [module.resource_group]
 source =  "../../module/azurerm_nsg"
 nsg = var.nsg
}

module "nic" {
  depends_on = [module.resource_group, module.vnet, module.subnet]
source = "../../module/azurerm_nic"
nic = {
    for k, v in var.nic :
    k => merge(v, {
      subnet_id = module.subnet.subnet_id[v.subnet_key]
    })
  }

}

module "vm" {
  depends_on = [module.nic]
  source = "../../module/azurerm_vm"
  vm = {
    for k, v in var.vm :
    k => merge(v, {
      nic_id = module.nic.nic_id[v.nic_key]
    })
  }
}

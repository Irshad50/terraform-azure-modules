module "resource_group" {
  source = "../../module/azurerm_resource_group"
  qa1    = var.qa1
}

module "vnet" {
  depends_on = [module.resource_group]
  source     = "../../module/azurerm_virtual_network"
  vnet       = var.vnet
}

module "subnet" {
  depends_on = [module.resource_group, module.vnet]
  source     = "../../module/azurerm_subnet"
  subnet     = var.subnet
}

module "pip" {
  depends_on = [module.resource_group, module.vnet, module.subnet]
  source     = "../../module/azurerm_pip"
  public_ips = var.public_ips
}

module "bastion" {
  depends_on = [module.resource_group, module.vnet, module.subnet, module.pip]
  source     = "../../module/azurerm_bastion"
  bastions = {
    for k, v in var.bastions :
    k => merge(v, {
      subnet_id            = module.subnet.subnet_id[v.subnet_key]
      public_ip_address_id = module.pip.public_ip_id[v.public_key]
    })
  }
}

module "nsg" {
  depends_on = [module.resource_group]
  source     = "../../module/azurerm_nsg"
  nsg        = var.nsg
}

module "nic" {
  depends_on = [module.resource_group, module.vnet, module.subnet]
  source     = "../../module/azurerm_nic"
  nic = {
    for k, v in var.nic :
    k => merge(v, {
      subnet_id = module.subnet.subnet_id[v.subnet_key]
    })
  }
}

# --- Key Vault Module (Generates & Stores Password in Key Vault) ---
module "key_vault" {
  depends_on = [module.resource_group]
  source     = "../../module/azurerm_key_vault"
  key_vaults = var.key_vaults
}

# --- Single / Multi VM Module ---
module "vm" {
  depends_on = [module.nic, module.key_vault]
  source     = "../../module/azurerm_vm"

  password = module.key_vault.vm_password

  vm = {
    for k, v in var.vm :
    k => merge(v, {
      nic_id = module.nic.nic_id[v.nic_key]
    })
  }
}

# --- Azure Load Balancer Module ---
module "lb" {
  depends_on = [module.resource_group, module.pip, module.nic]
  source     = "../../module/azurerm_lb"

  lb = {
    for k, v in var.lb :
    k => merge(v, {
      public_ip_id = module.pip.public_ip_id[v.public_key]
    })
  }

  lb_nic_associations = {
    for k, v in var.lb_nic_associations :
    k => merge(v, {
      nic_id = module.nic.nic_id[v.nic_key]
    })
  }
}

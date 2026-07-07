qa1 = {
rg1 = {
    name     = "rg_dev"
    location = "centralindia"
  }
  rg2 = {
     name     = "rg_prod"
    location = "eastus2"
  }
   rg3 = {
     name     = "rg_uat"
    location = "centralindia"
  }
}

vnet = {
  vnet1 = {
    name = "prod-vnet"
    resource_group_name = "rg_dev"
    location = "centralindia"
    address_space = ["10.0.0.0/16"]
  }
}

subnet = {
  subnet1 = {
    name             = "prod-subnet"
    resource_group_name          = "rg_dev"
    vnet_name        = "prod-vnet"
    address_prefixes = ["10.0.1.0/24"]
  }

  subnet2 = {
    name             = "prod-subnet1"
    resource_group_name          = "rg_dev"
    vnet_name        = "prod-vnet"
    address_prefixes = ["10.0.2.0/24"]
  }
  subnet3 = {
    name = "AzureBastionSubnet"
    resource_group_name          = "rg_dev"
    vnet_name        = "prod-vnet"
    address_prefixes = ["10.0.3.0/26"]
  }
}
public_ips = {

  pip1 = {
    name               = "bastion-pip"
    resource_group_name = "rg_dev"
    location           = "centralindia"
  }
}
bastions = {

  bastion1 = {
      name                = "my-bastion"
      location            = "centralindia"
      resource_group_name = "rg_dev"
      subnet_key = "subnet3"
      public_key = "pip1"
    }
}


nsg = {
  nsg1 = {
    name = "prod-nsg"
    location = "centralindia"
    resource_group_name = "rg_dev"
  }
  nsg2 = {
    name = "prod-nsg1"
    location = "eastus2"
    resource_group_name = "rg_prod"
  }
  nsg3 = {
    name = "uat-nsg2"
    location = "centralindia"
    resource_group_name = "rg_dev"
  }
}

nic = {
  nic1 = {
    name       = "prod_nic"
    location   = "centralindia"
    resource_group_name    = "rg_dev"
    subnet_key = "subnet1"
  }

  nic2 = {
    name       = "prod_nic1"
    location   = "centralindia"
    resource_group_name    = "rg_dev"
    subnet_key = "subnet2"
  }
  # nic3 = {
  #   name       = "prod_nic2"
  #   location   = "centralindia"
  #   resource_group_name    = "rg_dev"
  #   subnet_key = "subnet3"
  # }
}

vm = {

  vm1 = {
    name      = "prodvm1"
    location  = "centralindia"
    resource_group_name   = "rg_dev"
    size      = "Standard_D2s_V3"
    adminuser = "xxxxxxx"
    password  = "xxxxxxx"

    nic_key = "nic1"
  }

  vm2 = {
    name      = "devvm2"
    location  = "centralindia"
    resource_group_name   = "rg_dev"
    size      = "Standard_D2s_V3"
    adminuser = "axxxxxx"
    password  = "xxxxxxx"

    nic_key = "nic2"
  }
  

}
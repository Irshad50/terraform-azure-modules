variable "qa1" {
  type        = map(any)
  description = "Resource Group configuration map"
}

variable "vnet" {
  type        = map(any)
  description = "Virtual Network configuration map"
}

variable "subnet" {
  type        = map(any)
  description = "Subnet configuration map"
}

variable "public_ips" {
  type        = map(any)
  description = "Public IP configuration map"
}

variable "bastions" {
  type        = map(any)
  description = "Bastion Host configuration map"
}

variable "nsg" {
  type        = map(any)
  description = "Network Security Group configuration map"
}

variable "nic" {
  type        = map(any)
  description = "Network Interface configuration map"
}

variable "vm" {
  type        = map(any)
  description = "Virtual Machine configuration map"
}

variable "key_vaults" {
  type        = map(any)
  description = "Key Vault configuration map"
}

variable "lb" {
  type        = map(any)
  description = "Load Balancer configuration map"
}

variable "lb_nic_associations" {
  type        = map(any)
  description = "NIC to LB Backend Pool association map"
}
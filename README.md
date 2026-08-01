# Terraform Azure Reusable Modules

## Project Overview

This repository contains reusable Terraform modules for provisioning Azure infrastructure using Infrastructure as Code (IaC). Each Azure resource is implemented as an independent module, making the infrastructure modular, scalable, and easy to maintain.

The modules can be reused across multiple environments such as Development, Test, Pre-Production, and Production.

---

## Repository Structure

```
terraform-azure-modules/
│
├── azure_landing_zone/
│   └── dev/
│       ├── main.tf
│       ├── provider.tf
│       ├── variables.tf
│       ├── terraform.tfvars
│
├── module/
│   ├── azurerm_resource_group/
│   ├── azurerm_virtual_network/
│   ├── azurerm_subnet/
│   ├── azurerm_nsg/
│   ├── azurerm_pip/
│   ├── azurerm_nic/
│   ├── azurerm_vm/
│   └── azurerm_bastion/
│
└── README.md
```

---

# Azure Resources Covered

- Azure Resource Group
- Azure Virtual Network (VNet)
- Azure Subnet
- Azure Network Security Group (NSG)
- Azure Public IP
- Azure Network Interface (NIC)
- Azure Virtual Machine
- Azure Bastion

---

# Features

- Reusable Terraform Modules
- Modular Infrastructure Design
- Environment-based Deployment
- Easy to Scale
- Easy Maintenance
- Production-ready Structure
- Infrastructure as Code (IaC)

---

# Technologies Used

- Microsoft Azure
- Terraform
- AzureRM Provider
- Azure CLI
- Git
- GitHub

---

# Module Usage

Example:

```hcl
module "resource_group" {
  source   = "../../module/azurerm_resource_group"
  name     = "rg-dev"
  location = "Central India"
}

module "virtual_network" {
  source              = "../../module/azurerm_virtual_network"
  resource_group_name = module.resource_group.name
}
```

---

# Deployment Steps

Initialize Terraform

```bash
terraform init
```

Validate Configuration

```bash
terraform validate
```

Generate Execution Plan

```bash
terraform plan
```

Deploy Infrastructure

```bash
terraform apply
```

Destroy Infrastructure

```bash
terraform destroy
```

---

# Prerequisites

- Azure Subscription
- Azure CLI
- Terraform 1.x
- Git
- Visual Studio Code

---

# Future Enhancements

- Azure Load Balancer
- Azure Application Gateway
- Azure Firewall
- NAT Gateway
- Azure Key Vault
- Azure Monitor
- Log Analytics
- Azure Kubernetes Service (AKS)

---

# Learning Objectives

This project demonstrates:

- Terraform Module Development
- Infrastructure as Code (IaC)
- Azure Resource Provisioning
- Module Reusability
- Environment Separation
- Production-ready Terraform Project Structure

---

# Author

**MD Irshad Alam**

Azure DevOps Engineer

Azure | Terraform | Kubernetes | Azure DevOps | GitHub Actions | DevSecOps

---

⭐ If you found this project useful, consider giving it a Star.

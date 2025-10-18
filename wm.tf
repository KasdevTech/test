# Main Terraform configuration for deploying Databricks workspace
# This file uses the reusable module and loads variables from .tfvars files

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  # Backend configuration for state management
  # Uncomment and configure for remote state storage
  # backend "azurerm" {
  #   resource_group_name  = "terraform-state-rg"
  #   storage_account_name = "tfstatexxxxxxx"
  #   container_name       = "tfstate"
  #   key                  = "${var.service_name}-${var.environment}-${var.region}.terraform.tfstate"
  # }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

# Call the Databricks workspace module
module "databricks_workspace" {
  source = "../modules/databricks-workspace"

  # Required parameters
  workspace_name      = var.workspace_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_name        = var.service_name
  environment         = var.environment

  # Workspace configuration
  sku                         = var.sku
  managed_resource_group_name = var.managed_resource_group_name

  # VNet integration (using existing VNet and subnets)
  vnet_name                = var.vnet_name
  vnet_resource_group_name = var.vnet_resource_group_name
  private_subnet_name      = var.private_subnet_name
  public_subnet_name       = var.public_subnet_name
  private_nsg_association_id = var.private_nsg_association_id
  public_nsg_association_id  = var.public_nsg_association_id

  # Network security
  enable_no_public_ip                   = var.enable_no_public_ip
  public_network_access_enabled         = var.public_network_access_enabled
  network_security_group_rules_required = var.network_security_group_rules_required

  # Storage configuration
  storage_account_name = var.storage_account_name
  storage_account_sku  = var.storage_account_sku

  # Security
  infrastructure_encryption_enabled = var.infrastructure_encryption_enabled

  # Tags
  tags = var.tags
}

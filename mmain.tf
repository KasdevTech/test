# Databricks Workspace Module
# This module creates an Azure Databricks workspace with configurable settings
# Supports integration with existing VNet and subnets

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

# Data source for existing resource group
data "azurerm_resource_group" "existing" {
  name = var.resource_group_name
}

# Data source for existing VNet (if using VNet injection)
data "azurerm_virtual_network" "existing" {
  count               = var.vnet_name != null ? 1 : 0
  name                = var.vnet_name
  resource_group_name = var.vnet_resource_group_name != null ? var.vnet_resource_group_name : var.resource_group_name
}

# Data source for existing subnets
data "azurerm_subnet" "private" {
  count                = var.private_subnet_name != null ? 1 : 0
  name                 = var.private_subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.vnet_resource_group_name != null ? var.vnet_resource_group_name : var.resource_group_name
}

data "azurerm_subnet" "public" {
  count                = var.public_subnet_name != null ? 1 : 0
  name                 = var.public_subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.vnet_resource_group_name != null ? var.vnet_resource_group_name : var.resource_group_name
}

# Azure Databricks Workspace
resource "azurerm_databricks_workspace" "workspace" {
  name                = var.workspace_name
  resource_group_name = data.azurerm_resource_group.existing.name
  location            = var.location
  sku                 = var.sku

  # Managed Resource Group (created by Databricks)
  managed_resource_group_name = var.managed_resource_group_name != null ? var.managed_resource_group_name : "${var.workspace_name}-managed-rg"

  # VNet Integration (if enabled)
  dynamic "custom_parameters" {
    for_each = var.vnet_name != null ? [1] : []
    content {
      virtual_network_id                                   = data.azurerm_virtual_network.existing[0].id
      private_subnet_name                                  = var.private_subnet_name
      public_subnet_name                                   = var.public_subnet_name
      private_subnet_network_security_group_association_id = var.private_nsg_association_id
      public_subnet_network_security_group_association_id  = var.public_nsg_association_id
      
      # Enable/Disable public network access
      public_ip_name                                       = var.enable_no_public_ip ? null : "${var.workspace_name}-pip"
      no_public_ip                                         = var.enable_no_public_ip
      
      # Storage account configuration
      storage_account_name                                 = var.storage_account_name
      storage_account_sku_name                             = var.storage_account_sku
    }
  }

  # Security and compliance settings
  public_network_access_enabled         = var.public_network_access_enabled
  network_security_group_rules_required = var.network_security_group_rules_required

  # Infrastructure encryption (for enhanced security)
  infrastructure_encryption_enabled = var.infrastructure_encryption_enabled

  # Tags for resource management
  tags = merge(
    var.tags,
    {
      Service     = var.service_name
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  )
}

# Optional: Route Table Association for Public Subnet
# Use this if you need custom routing (e.g., Palo Alto firewall)
resource "azurerm_subnet_route_table_association" "public" {
  count          = var.enable_route_table_association && var.route_table_id != null ? 1 : 0
  subnet_id      = data.azurerm_subnet.public[0].id
  route_table_id = var.route_table_id

  depends_on = [azurerm_databricks_workspace.workspace]
}

# Optional: Route Table Association for Private Subnet
resource "azurerm_subnet_route_table_association" "private" {
  count          = var.enable_route_table_association && var.route_table_id != null ? 1 : 0
  subnet_id      = data.azurerm_subnet.private[0].id
  route_table_id = var.route_table_id

  depends_on = [azurerm_databricks_workspace.workspace]
}

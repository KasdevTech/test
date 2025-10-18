# Databricks Workspace Module Variables

# Required Variables
variable "workspace_name" {
  description = "Name of the Azure Databricks workspace"
  type        = string
  validation {
    condition     = length(var.workspace_name) >= 3 && length(var.workspace_name) <= 64
    error_message = "Workspace name must be between 3 and 64 characters."
  }
}

variable "resource_group_name" {
  description = "Name of the existing resource group"
  type        = string
}

variable "location" {
  description = "Azure region for the Databricks workspace"
  type        = string
}

variable "service_name" {
  description = "Service identifier (e.g., abc, def)"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., nonprod, prod)"
  type        = string
  validation {
    condition     = contains(["nonprod", "prod"], var.environment)
    error_message = "Environment must be either 'nonprod' or 'prod'."
  }
}

# Optional Variables - Workspace Configuration
variable "sku" {
  description = "SKU tier for Databricks workspace (standard, premium, trial)"
  type        = string
  default     = "premium"
  validation {
    condition     = contains(["standard", "premium", "trial"], var.sku)
    error_message = "SKU must be one of: standard, premium, trial."
  }
}

variable "managed_resource_group_name" {
  description = "Name of the managed resource group (auto-generated if not provided)"
  type        = string
  default     = null
}

# VNet Integration Variables
variable "vnet_name" {
  description = "Name of the existing virtual network (null for default Databricks-managed VNet)"
  type        = string
  default     = null
}

variable "vnet_resource_group_name" {
  description = "Resource group of the VNet (defaults to workspace resource group if not specified)"
  type        = string
  default     = null
}

variable "private_subnet_name" {
  description = "Name of the existing private subnet for VNet injection"
  type        = string
  default     = null
}

variable "public_subnet_name" {
  description = "Name of the existing public subnet for VNet injection"
  type        = string
  default     = null
}

variable "private_nsg_association_id" {
  description = "Network Security Group association ID for private subnet"
  type        = string
  default     = null
}

variable "public_nsg_association_id" {
  description = "Network Security Group association ID for public subnet"
  type        = string
  default     = null
}

# Network Security Variables
variable "enable_no_public_ip" {
  description = "Enable Secure Cluster Connectivity (no public IP for cluster nodes)"
  type        = bool
  default     = true
}

variable "public_network_access_enabled" {
  description = "Enable public network access to workspace"
  type        = bool
  default     = true
}

variable "network_security_group_rules_required" {
  description = "Does the data plane to control plane communication require NSG rules"
  type        = string
  default     = "AllRules"
  validation {
    condition     = contains(["AllRules", "NoAzureDatabricksRules"], var.network_security_group_rules_required)
    error_message = "Must be either 'AllRules' or 'NoAzureDatabricksRules'."
  }
}

# Storage Configuration
variable "storage_account_name" {
  description = "Name for the DBFS root storage account (auto-generated if not provided)"
  type        = string
  default     = null
}

variable "storage_account_sku" {
  description = "SKU for the DBFS root storage account"
  type        = string
  default     = "Standard_GRS"
}

# Security Variables
variable "infrastructure_encryption_enabled" {
  description = "Enable infrastructure encryption (requires Premium SKU)"
  type        = bool
  default     = false
}

# Tags
variable "tags" {
  description = "Additional tags for the Databricks workspace"
  type        = map(string)
  default     = {}
}

# Advanced Network Configuration (Optional)
variable "enable_route_table_association" {
  description = "Enable route table association for subnets (for custom routing like Palo Alto)"
  type        = bool
  default     = false
}

variable "route_table_id" {
  description = "ID of existing route table to associate with Databricks subnets"
  type        = string
  default     = null
}

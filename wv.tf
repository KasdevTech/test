# Variables for workspace deployment
# These will be populated by .tfvars files for each workspace configuration

# Azure Configuration
variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

# Required Variables
variable "workspace_name" {
  description = "Name of the Azure Databricks workspace"
  type        = string
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
}

variable "region" {
  description = "Region shorthand (e.g., east, west) for naming"
  type        = string
}

# Optional Variables - Workspace Configuration
variable "sku" {
  description = "SKU tier for Databricks workspace"
  type        = string
  default     = "premium"
}

variable "managed_resource_group_name" {
  description = "Name of the managed resource group"
  type        = string
  default     = null
}

# VNet Integration Variables
variable "vnet_name" {
  description = "Name of the existing virtual network"
  type        = string
  default     = null
}

variable "vnet_resource_group_name" {
  description = "Resource group of the VNet"
  type        = string
  default     = null
}

variable "private_subnet_name" {
  description = "Name of the existing private subnet"
  type        = string
  default     = null
}

variable "public_subnet_name" {
  description = "Name of the existing public subnet"
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
  description = "Enable Secure Cluster Connectivity"
  type        = bool
  default     = true
}

variable "public_network_access_enabled" {
  description = "Enable public network access to workspace"
  type        = bool
  default     = true
}

variable "network_security_group_rules_required" {
  description = "NSG rules requirement for data plane communication"
  type        = string
  default     = "AllRules"
}

# Storage Configuration
variable "storage_account_name" {
  description = "Name for the DBFS root storage account"
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
  description = "Enable infrastructure encryption"
  type        = bool
  default     = false
}

# Tags
variable "tags" {
  description = "Additional tags for resources"
  type        = map(string)
  default     = {}
}

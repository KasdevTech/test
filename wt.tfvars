# Terraform variables for ABC Service - NonProd - East US
# Workspace: abc-nonprod-east

# Azure Configuration
subscription_id = "YOUR_SUBSCRIPTION_ID_HERE"

# Workspace Configuration
workspace_name      = "adb-abc-nonprod-eastus"
resource_group_name = "rg-abc-nonprod-eastus"
location            = "eastus"
service_name        = "abc"
environment         = "nonprod"
region              = "east"

# Databricks SKU
sku = "premium"

# Managed Resource Group
managed_resource_group_name = "adb-abc-nonprod-eastus-managed-rg"

# VNet Integration (Update with your existing VNet/Subnet details)
vnet_name                = "vnet-abc-nonprod-eastus"
vnet_resource_group_name = "rg-abc-nonprod-eastus"
private_subnet_name      = "snet-databricks-private"
public_subnet_name       = "snet-databricks-public"

# NSG Associations (Update after NSG is associated with subnets)
# private_nsg_association_id = "/subscriptions/{subscription-id}/resourceGroups/{rg-name}/providers/Microsoft.Network/networkSecurityGroups/{nsg-name}"
# public_nsg_association_id  = "/subscriptions/{subscription-id}/resourceGroups/{rg-name}/providers/Microsoft.Network/networkSecurityGroups/{nsg-name}"

# Network Security
enable_no_public_ip                   = true
public_network_access_enabled         = true
network_security_group_rules_required = "AllRules"

# Storage Configuration (optional - auto-generated if not specified)
# storage_account_name = "stadbabc001"
storage_account_sku = "Standard_GRS"

# Security
infrastructure_encryption_enabled = false

# Tags
tags = {
  Service     = "abc"
  Environment = "nonprod"
  Region      = "eastus"
  CostCenter  = "IT"
  Owner       = "DataTeam"
}

# Databricks Workspace Module Outputs

output "workspace_id" {
  description = "The ID of the Databricks workspace"
  value       = azurerm_databricks_workspace.workspace.id
}

output "workspace_url" {
  description = "The workspace URL which is of the form 'adb-{workspaceId}.{random}.azuredatabricks.net'"
  value       = "https://${azurerm_databricks_workspace.workspace.workspace_url}"
}

output "workspace_name" {
  description = "The name of the Databricks workspace"
  value       = azurerm_databricks_workspace.workspace.name
}

output "managed_resource_group_id" {
  description = "The ID of the managed resource group created by Databricks"
  value       = azurerm_databricks_workspace.workspace.managed_resource_group_id
}

output "managed_resource_group_name" {
  description = "The name of the managed resource group created by Databricks"
  value       = azurerm_databricks_workspace.workspace.managed_resource_group_name
}

output "workspace_storage_account_identity" {
  description = "The identity that has access to the workspace storage account"
  value       = azurerm_databricks_workspace.workspace.storage_account_identity
}

output "location" {
  description = "The location of the Databricks workspace"
  value       = azurerm_databricks_workspace.workspace.location
}

# Outputs for workspace deployment

output "workspace_id" {
  description = "The ID of the Databricks workspace"
  value       = module.databricks_workspace.workspace_id
}

output "workspace_url" {
  description = "The workspace URL"
  value       = module.databricks_workspace.workspace_url
}

output "workspace_name" {
  description = "The name of the Databricks workspace"
  value       = module.databricks_workspace.workspace_name
}

output "managed_resource_group_name" {
  description = "The name of the managed resource group"
  value       = module.databricks_workspace.managed_resource_group_name
}

output "location" {
  description = "The location of the workspace"
  value       = module.databricks_workspace.location
}

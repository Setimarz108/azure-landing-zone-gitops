output "log_analytics_workspace_id" {
  description = "Log Analytics workspace ID"
  value       = azurerm_log_analytics_workspace.main.id
}

output "log_analytics_workspace_key" {
  description = "Log Analytics workspace primary key"
  value       = azurerm_log_analytics_workspace.main.primary_shared_key
  sensitive   = true
}

output "application_insights_id" {
  description = "Application Insights ID"
  value       = azurerm_application_insights.main.id
}

output "application_insights_key" {
  description = "Application Insights instrumentation key"
  value       = azurerm_application_insights.main.instrumentation_key
  sensitive   = true
}

output "application_insights_connection_string" {
  description = "Application Insights connection string"
  value       = azurerm_application_insights.main.connection_string
  sensitive   = true
}

output "storage_account_id" {
  description = "Diagnostics storage account ID"
  value       = azurerm_storage_account.diagnostics.id
}

output "action_group_id" {
  description = "Action group ID for alerts"
  value       = azurerm_monitor_action_group.main.id
}

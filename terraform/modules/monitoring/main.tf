# Monitoring Module - Centralized Logging and Application Insights
# Implements Azure Monitor best practices for enterprise environments

# Log Analytics Workspace - Central logging hub
resource "azurerm_log_analytics_workspace" "main" {
  name                = "${var.naming_prefix}-law-001"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.log_analytics_sku
  retention_in_days   = var.log_retention_days

  tags = var.tags
}

# Application Insights for application performance monitoring
resource "azurerm_application_insights" "main" {
  name                = "${var.naming_prefix}-appi-001"
  location            = var.location
  resource_group_name = var.resource_group_name
  workspace_id        = azurerm_log_analytics_workspace.main.id
  application_type    = "web"

  tags = var.tags
}

# Storage Account for diagnostic logs (GDPR compliant with encryption)
resource "azurerm_storage_account" "diagnostics" {
  name                     = replace("${var.naming_prefix}diagst001", "-", "")
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  
  # GDPR compliance requirements
  min_tls_version                = "TLS1_2"
  allow_nested_items_to_be_public = false
  
  blob_properties {
    delete_retention_policy {
      days = var.log_retention_days
    }
    container_delete_retention_policy {
      days = var.log_retention_days
    }
  }

  tags = var.tags
}

# Action Group for alerts (email notifications)
resource "azurerm_monitor_action_group" "main" {
  name                = "${var.naming_prefix}-ag-001"
  resource_group_name = var.resource_group_name
  short_name          = "AlertGroup"

  email_receiver {
    name          = "admin-email"
    email_address = var.admin_email
  }

  tags = var.tags
}

# Activity Log Alert for resource deletions (security monitoring)
resource "azurerm_monitor_activity_log_alert" "resource_deletion" {
  name                = "${var.naming_prefix}-alert-deletion-001"
  resource_group_name = var.resource_group_name
  scopes              = [var.resource_group_id]
  description         = "Alert when resources are deleted"

  criteria {
    resource_id    = var.resource_group_id
    operation_name = "Microsoft.Resources/subscriptions/resourceGroups/delete"
    category       = "Administrative"
  }

  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }

  tags = var.tags
}

# Diagnostic Settings for Network Security Groups
resource "azurerm_monitor_diagnostic_setting" "nsg_diagnostics" {
  count                      = length(var.nsg_ids)
  name                       = "${var.naming_prefix}-diag-nsg-${count.index + 1}"
  target_resource_id         = var.nsg_ids[count.index]
  log_analytics_workspace_id = azurerm_log_analytics_workspace.main.id
  storage_account_id         = azurerm_storage_account.diagnostics.id

  enabled_log {
    category = "NetworkSecurityGroupEvent"
  }

  enabled_log {
    category = "NetworkSecurityGroupRuleCounter"
  }

  metric {
    category = "AllMetrics"
    enabled  = true
  }
}

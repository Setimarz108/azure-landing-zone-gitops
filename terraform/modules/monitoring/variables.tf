variable "naming_prefix" {
  description = "Naming prefix for resources"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "resource_group_id" {
  description = "Resource group ID for monitoring scope"
  type        = string
}

variable "log_analytics_sku" {
  description = "SKU for Log Analytics workspace"
  type        = string
  default     = "PerGB2018"
}

variable "log_retention_days" {
  description = "Log retention period in days (GDPR compliance)"
  type        = number
  default     = 90
}

variable "admin_email" {
  description = "Admin email for alerts"
  type        = string
  default     = "sebastian.marquez.dev@gmail.com"
}

variable "nsg_ids" {
  description = "List of NSG IDs for diagnostic settings"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

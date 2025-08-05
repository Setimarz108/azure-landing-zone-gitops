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
  description = "Resource group ID for policy assignments"
  type        = string
}

variable "environment" {
  description = "Environment name (affects security settings)"
  type        = string
}

variable "allowed_subnet_ids" {
  description = "Subnet IDs allowed to access Key Vault"
  type        = list(string)
  default     = []
}

variable "admin_password" {
  description = "Admin password to store in Key Vault"
  type        = string
  default     = "ChangeMe123!"
  sensitive   = true
}

variable "database_connection_string" {
  description = "Database connection string to store in Key Vault"
  type        = string
  default     = "Server=localhost;Database=demo;Integrated Security=true;"
  sensitive   = true
}

variable "security_contact_email" {
  description = "Email for security alerts"
  type        = string
  default     = "sebastian.marquez.dev@gmail.com"
}

variable "security_contact_phone" {
  description = "Phone for security alerts"
  type        = string
  default     = "+49-XXX-XXX-XXXX"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

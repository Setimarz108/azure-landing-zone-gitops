variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "Germany West"
}

variable "admin_username" {
  description = "Admin username for resources"
  type        = string
  default     = "azureadmin"
}

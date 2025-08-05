variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
  
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod."
  }
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "germanywestcentral"
}

variable "admin_username" {
  description = "Admin username for resources"
  type        = string
  default     = "azureadmin"
}

variable "admin_email" {
  description = "Admin email for monitoring alerts"
  type        = string
  default     = "sebastian.marquez.dev@gmail.com"
}

variable "security_contact_email" {
  description = "Security contact email for Azure Security Center"
  type        = string
  default     = "sebastian.marquez.dev@gmail.com"
}

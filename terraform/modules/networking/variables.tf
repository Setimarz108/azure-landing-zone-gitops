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

variable "vnet_address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "management_subnet_prefix" {
  description = "Address prefix for management subnet"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "application_subnet_prefix" {
  description = "Address prefix for application subnet"
  type        = list(string)
  default     = ["10.0.2.0/24"]
}

variable "database_subnet_prefix" {
  description = "Address prefix for database subnet"
  type        = list(string)
  default     = ["10.0.3.0/24"]
}

variable "admin_source_ip" {
  description = "Source IP range for admin access (GDPR compliance)"
  type        = string
  default     = "0.0.0.0/0" # Should be restricted in production
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

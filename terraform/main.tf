# Azure Landing Zone - Main Configuration
# Sebastian Marquez - Azure Solutions Architect Expert (AZ-305)

terraform {
  required_version = ">= 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Resource naming convention
locals {
  environment = var.environment
  location    = var.location
  project     = "azlz" # Azure Landing Zone
  
  # Standard naming: azlz-dev-rg-001
  naming_convention = "${local.project}-${local.environment}"
}

# Main resource group
resource "azurerm_resource_group" "main" {
  name     = "${local.naming_convention}-rg-001"
  location = local.location
  
  tags = {
    Environment   = local.environment
    Project      = "Azure Landing Zone"
    ManagedBy    = "Terraform"
    Owner        = "Sebastian Marquez"
    Compliance   = "GDPR"
  }
}

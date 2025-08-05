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
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
}

# Resource naming convention
locals {
  environment = var.environment
  location    = var.location
  project     = "azlz" # Azure Landing Zone
  
  # Standard naming: azlz-dev-rg-001
  naming_convention = "${local.project}-${local.environment}"
  
  # Common tags for all resources
  common_tags = {
    Environment   = local.environment
    Project      = "Azure Landing Zone"
    ManagedBy    = "Terraform"
    Owner        = "Sebastian Marquez"
    Compliance   = "GDPR"
    Region       = local.location
    CostCenter   = "IT-Infrastructure"
    CreatedDate  = formatdate("YYYY-MM-DD", timestamp())
  }
}

# Main resource group
resource "azurerm_resource_group" "main" {
  name     = "${local.naming_convention}-rg-001"
  location = local.location
  
  tags = local.common_tags
}

# Networking Module
module "networking" {
  source = "./modules/networking"
  
  naming_prefix       = local.naming_convention
  location           = local.location
  resource_group_name = azurerm_resource_group.main.name
  
  # Environment-specific network sizing
  vnet_address_space = var.environment == "prod" ? ["10.0.0.0/16"] : ["10.1.0.0/16"]
  
  tags = local.common_tags
}

# Monitoring Module
module "monitoring" {
  source = "./modules/monitoring"
  
  naming_prefix       = local.naming_convention
  location           = local.location
  resource_group_name = azurerm_resource_group.main.name
  resource_group_id  = azurerm_resource_group.main.id
  
  # Environment-specific monitoring settings
  log_retention_days = var.environment == "prod" ? 365 : 90
  admin_email       = var.admin_email
  
  # Enable NSG diagnostics
  nsg_ids = [
    module.networking.management_nsg_id,
    module.networking.application_nsg_id,
    module.networking.database_nsg_id
  ]
  
  tags = local.common_tags
}

# Security Module
module "security" {
  source = "./modules/security"
  
  naming_prefix       = local.naming_convention
  location           = local.location
  resource_group_name = azurerm_resource_group.main.name
  resource_group_id  = azurerm_resource_group.main.id
  environment        = local.environment
  
  # Allow Key Vault access from management subnet
  allowed_subnet_ids = [module.networking.management_subnet_id]
  
  security_contact_email = var.security_contact_email
  
  tags = local.common_tags
}

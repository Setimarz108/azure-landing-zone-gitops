output "resource_group_name" {
  description = "Name of the main resource group"
  value       = azurerm_resource_group.main.name
}

output "resource_group_location" {
  description = "Location of the main resource group"
  value       = azurerm_resource_group.main.location
}

output "virtual_network_id" {
  description = "Virtual network ID"
  value       = module.networking.vnet_id
}

output "virtual_network_name" {
  description = "Virtual network name"
  value       = module.networking.vnet_name
}

output "subnet_ids" {
  description = "Map of subnet IDs"
  value = {
    management  = module.networking.management_subnet_id
    application = module.networking.application_subnet_id
    database    = module.networking.database_subnet_id
  }
}

output "vnet_id" {
  description = "Virtual network ID"
  value       = azurerm_virtual_network.main.id
}

output "vnet_name" {
  description = "Virtual network name"
  value       = azurerm_virtual_network.main.name
}

output "management_subnet_id" {
  description = "Management subnet ID"
  value       = azurerm_subnet.management.id
}

output "application_subnet_id" {
  description = "Application subnet ID"  
  value       = azurerm_subnet.application.id
}

output "database_subnet_id" {
  description = "Database subnet ID"
  value       = azurerm_subnet.database.id
}

output "management_nsg_id" {
  description = "Management NSG ID"
  value       = azurerm_network_security_group.management.id
}

output "application_nsg_id" {
  description = "Application NSG ID"
  value       = azurerm_network_security_group.application.id
}

output "database_nsg_id" {
  description = "Database NSG ID"
  value       = azurerm_network_security_group.database.id
}

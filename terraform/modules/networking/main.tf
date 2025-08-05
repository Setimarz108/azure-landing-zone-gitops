# Networking Module - Hub-Spoke Architecture
# Implements Azure Landing Zone networking best practices

# Virtual Network
resource "azurerm_virtual_network" "main" {
  name                = "${var.naming_prefix}-vnet-001"
  address_space       = var.vnet_address_space
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = var.tags
}

# Management Subnet (for admin resources)
resource "azurerm_subnet" "management" {
  name                 = "${var.naming_prefix}-snet-mgmt-001"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = var.management_subnet_prefix
}

# Application Subnet (for workloads)
resource "azurerm_subnet" "application" {
  name                 = "${var.naming_prefix}-snet-app-001"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = var.application_subnet_prefix
}

# Database Subnet (for data tier)
resource "azurerm_subnet" "database" {
  name                 = "${var.naming_prefix}-snet-db-001"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = var.database_subnet_prefix
  
  # Database subnet delegation
  delegation {
    name = "database-delegation"
    service_delegation {
      name = "Microsoft.Sql/managedInstances"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
        "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"
      ]
    }
  }
}

# Network Security Group for Management Subnet
resource "azurerm_network_security_group" "management" {
  name                = "${var.naming_prefix}-nsg-mgmt-001"
  location            = var.location
  resource_group_name = var.resource_group_name

  # Allow RDP from specific IP ranges (GDPR compliance - restricted access)
  security_rule {
    name                       = "AllowRDPInbound"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = var.admin_source_ip
    destination_address_prefix = "*"
  }

  # Allow SSH for Linux management
  security_rule {
    name                       = "AllowSSHInbound"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.admin_source_ip
    destination_address_prefix = "*"
  }

  tags = var.tags
}

# Network Security Group for Application Subnet
resource "azurerm_network_security_group" "application" {
  name                = "${var.naming_prefix}-nsg-app-001"
  location            = var.location
  resource_group_name = var.resource_group_name

  # Allow HTTP traffic
  security_rule {
    name                       = "AllowHTTPInbound"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # Allow HTTPS traffic
  security_rule {
    name                       = "AllowHTTPSInbound"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = var.tags
}

# Network Security Group for Database Subnet
resource "azurerm_network_security_group" "database" {
  name                = "${var.naming_prefix}-nsg-db-001"
  location            = var.location
  resource_group_name = var.resource_group_name

  # Allow SQL traffic only from application subnet
  security_rule {
    name                       = "AllowSQLFromAppSubnet"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "1433"
    source_address_prefixes    = var.application_subnet_prefix
    destination_address_prefix = "*"
  }

  # Deny all other inbound traffic
  security_rule {
    name                       = "DenyAllInbound"
    priority                   = 4000
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = var.tags
}

# Associate NSGs with Subnets
resource "azurerm_subnet_network_security_group_association" "management" {
  subnet_id                 = azurerm_subnet.management.id
  network_security_group_id = azurerm_network_security_group.management.id
}

resource "azurerm_subnet_network_security_group_association" "application" {
  subnet_id                 = azurerm_subnet.application.id
  network_security_group_id = azurerm_network_security_group.application.id
}

resource "azurerm_subnet_network_security_group_association" "database" {
  subnet_id                 = azurerm_subnet.database.id
  network_security_group_id = azurerm_network_security_group.database.id
}

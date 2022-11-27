# Create Virtual Network
resource "azurerm_virtual_network" "aksvnet" {
  name                = "${var.aks_name}-vnet-${var.environment}"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  address_space       = [element(var.address_space, 0)]
}

# Create a Subnet for Gateway
resource "azurerm_subnet" "Gateway" {
  name                 = "GatewaySubnet"
  virtual_network_name = azurerm_virtual_network.aksvnet.name
  resource_group_name  = azurerm_resource_group.aks_rg.name
  address_prefixes     = [element(var.address_space, 1)]
}

# Create a Subnet for Private A
resource "azurerm_subnet" "aks-priva" {
  name                 = "priva-default-subnet-${var.environment}"
  virtual_network_name = azurerm_virtual_network.aksvnet.name
  resource_group_name  = azurerm_resource_group.aks_rg.name
  address_prefixes     = [element(var.address_space, 2)]
}

# Create a Subnet for Public A
resource "azurerm_subnet" "aks-puba" {
  name                 = "puba-default-subnet-${var.environment}"
  virtual_network_name = azurerm_virtual_network.aksvnet.name
  resource_group_name  = azurerm_resource_group.aks_rg.name
  address_prefixes     = [element(var.address_space, 3)]
}

# Create a Subnet for Bastion
resource "azurerm_subnet" "bastion" {
  name                 = "AzureBastionSubnet"
  virtual_network_name = azurerm_virtual_network.aksvnet.name
  resource_group_name  = azurerm_resource_group.aks_rg.name
  address_prefixes     = [element(var.address_space, 4)]
}

# Create a Subnet for AKS
resource "azurerm_subnet" "aks-default" {
  name                 = "aks-default-subnet-${var.environment}"
  virtual_network_name = azurerm_virtual_network.aksvnet.name
  resource_group_name  = azurerm_resource_group.aks_rg.name
  address_prefixes     = [element(var.address_space, 5)]
}

#NSG Priv A
resource "azurerm_network_security_group" "priva-azure-nsg" {
  name                = "priva-default-subnet-nsg-${var.environment}"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name

  dynamic "security_rule" {
    iterator = rule
    for_each = var.networkrule
    content {
      name                       = rule.value.name
      priority                   = rule.value.priority
      direction                  = rule.value.direction
      access                     = rule.value.access
      protocol                   = rule.value.protocol
      source_port_range          = rule.value.source_port_range
      destination_port_range     = rule.value.destination_port_range
      source_address_prefix      = rule.value.source_address_prefix
      destination_address_prefix = rule.value.destination_address_prefix

    }
  }
}

#NSG PUB A
resource "azurerm_network_security_group" "puba-azure-nsg" {
  name                = "puba-default-subnet-nsg-${var.environment}"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name

  dynamic "security_rule" {
    iterator = rule
    for_each = var.networkruleappgw
    content {
      name                       = rule.value.name
      priority                   = rule.value.priority
      direction                  = rule.value.direction
      access                     = rule.value.access
      protocol                   = rule.value.protocol
      source_port_range          = rule.value.source_port_range
      destination_port_range     = rule.value.destination_port_range
      source_address_prefix      = rule.value.source_address_prefix
      destination_address_prefix = rule.value.destination_address_prefix

    }
  }
}

#NSG AKS
resource "azurerm_network_security_group" "aks-azure-nsg" {
  name                = "aks-default-subnet-${var.environment}"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name

  dynamic "security_rule" {
    iterator = rule
    for_each = var.networkrule
    content {
      name                       = rule.value.name
      priority                   = rule.value.priority
      direction                  = rule.value.direction
      access                     = rule.value.access
      protocol                   = rule.value.protocol
      source_port_range          = rule.value.source_port_range
      destination_port_range     = rule.value.destination_port_range
      source_address_prefix      = rule.value.source_address_prefix
      destination_address_prefix = rule.value.destination_address_prefix

    }
  }
}

#Association
#priva
resource "azurerm_subnet_network_security_group_association" "nsg-ass-priva" {
  subnet_id                 = azurerm_subnet.aks-priva.id
  network_security_group_id = azurerm_network_security_group.priva-azure-nsg.id
}

#puba
resource "azurerm_subnet_network_security_group_association" "nsg-ass-puba" {
  subnet_id                 = azurerm_subnet.aks-puba.id
  network_security_group_id = azurerm_network_security_group.puba-azure-nsg.id
}

#aks
resource "azurerm_subnet_network_security_group_association" "nsg-ass-aks" {
  subnet_id                 = azurerm_subnet.aks-default.id
  network_security_group_id = azurerm_network_security_group.aks-azure-nsg.id
}
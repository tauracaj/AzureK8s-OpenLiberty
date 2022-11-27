# Documentation Reference: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kubernetes_service_versions
# Datasource to get the subnets 
data "azurerm_subnet" "aks-subnet-source" {
  name                 = azurerm_subnet.aks-default.name
  virtual_network_name = azurerm_virtual_network.aksvnet.name
  resource_group_name  = azurerm_resource_group.aks_rg.name
  #depends_on           = [azurerm_virtual_network.aksvnet]
}

data "azurerm_subnet" "puba-subnet-source" {
  name                 = azurerm_subnet.aks-puba.name
  virtual_network_name = azurerm_virtual_network.aksvnet.name
  resource_group_name  = azurerm_resource_group.aks_rg.name
  #depends_on           = [azurerm_virtual_network.aksvnet]
}

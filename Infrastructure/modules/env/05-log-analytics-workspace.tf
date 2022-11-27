# Create Log Analytics Workspace

resource "azurerm_log_analytics_workspace" "loganalytic" {
  name                = "logs-${random_pet.aksrandom.id}-${var.environment}"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  retention_in_days   = 30
}
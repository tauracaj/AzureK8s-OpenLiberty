# Terraform Resource to Create Azure User Assigned Identity
resource "azurerm_user_assigned_identity" "aks_identity" {
  location            = azurerm_resource_group.aks_rg.location
  name                = "${var.resource_group_name}-id-${var.environment}"
  resource_group_name = azurerm_resource_group.aks_rg.name
}
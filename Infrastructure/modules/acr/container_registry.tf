resource "azurerm_resource_group" "global_rg" {
  name     = "${var.resource_group_name}-${var.environment}"
  location = var.location
  tags = {
    Environment = var.environment
  }
}

resource "random_pet" "cr_name" {
  keepers = {
    rg = azurerm_resource_group.global_rg.id
  }
  separator = ""
  length    = 1
}

resource "azurerm_container_registry" "acr" {
  name                = "${random_pet.cr_name.id}cr${var.environment}"
  resource_group_name = azurerm_resource_group.global_rg.name
  location            = azurerm_resource_group.global_rg.location
  sku                 = var.acr_sku
  admin_enabled       = false

  tags = {
    Environment = var.environment
  }
}
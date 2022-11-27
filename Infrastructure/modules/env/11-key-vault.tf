#Create azure kv
resource "azurerm_key_vault" "key_vault" {
  name                       = "${var.key_vault}-key-vlt-${var.environment}"
  location                   = azurerm_resource_group.aks_rg.location
  resource_group_name        = azurerm_resource_group.aks_rg.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  enable_rbac_authorization  = false
  soft_delete_retention_days = 7

  sku_name = "standard"
}

#Create azure kv access policy current
resource "azurerm_key_vault_access_policy" "key_vault_access" {
    key_vault_id = azurerm_key_vault.key_vault.id
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
      "Create",
      "List"
    ]

    secret_permissions = [
      "Get",
      "Set",
      "List",
      "Delete"      
    ]
}

#Create azure kv access policy current 
resource "azurerm_key_vault_access_policy" "key_vault_access_2" {
    key_vault_id = azurerm_key_vault.key_vault.id
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
      "Create",
      "List"
    ]

    secret_permissions = [
      "Get",
      "Set",
      "List",
      "Delete"      
    ]
}

resource "random_pet" "key_vault_name" {
  length = 1
}
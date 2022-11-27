# Create Outputs
# 1. Resource Group Location
# 2. Resource Group Id
# 3. Resource Group Name
# 4. Resource Group Tags

output "location" {
  value = azurerm_resource_group.sa_rg.location
}

output "resource_group_id" {
  value = azurerm_resource_group.sa_rg.id
}

output "resource_group_name" {
  value = azurerm_resource_group.sa_rg.name
}

output "storage_account_name" {
  value = azurerm_storage_account.storage_acc.name
}

output "storage_account_id" {
  value = azurerm_storage_account.storage_acc.id
}



# Create Outputs

output "location" {
  value = azurerm_resource_group.global_rg.location
}

output "resource_group_id" {
  value = azurerm_resource_group.global_rg.id
}

output "resource_group_name" {
  value = azurerm_resource_group.global_rg.name
}

output "resource_group_tags" {
  value = azurerm_resource_group.global_rg.tags
}

output "acr_name" {
  value = azurerm_container_registry.acr.name
}

output "acr_id" {
  value = azurerm_container_registry.acr.id
}

output "container_registery_uri" {
  value = azurerm_container_registry.acr.login_server
}
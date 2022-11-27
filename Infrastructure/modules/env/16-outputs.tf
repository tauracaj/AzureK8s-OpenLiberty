# Create Outputs
# 1. Resource Group Location
# 2. Resource Group Id
# 3. Resource Group Name
# 4. Resource Group Tags

# Azure location
output "location" {
  value = azurerm_resource_group.aks_rg.location
}

# Azure RG ID
output "resource_group_id" {
  value = azurerm_resource_group.aks_rg.id
}

# Azure RG Name
output "resource_group_name" {
  value = azurerm_resource_group.aks_rg.name
}

# Azure RG Tags
output "resource_group_tags" {
  value = azurerm_resource_group.aks_rg.tags
}

# Azure AKS Versions Datasource current
output "versions" {
  value = data.azurerm_kubernetes_service_versions.current.versions
}

# Azure AKS Versions Datasource latest
output "latest_version" {
  value = data.azurerm_kubernetes_service_versions.current.latest_version
}

# Azure AD Group Id
output "azure_ad_group_id" {
  value = azuread_group.aks_administrators.id
}

# Azure AD Group Object Id
output "azure_ad_group_objectid" {
  value = azuread_group.aks_administrators.object_id
}



# Azure AKS Outputs
output "aks_cluster_id" {
  value = azurerm_kubernetes_cluster.aks_cluster.id
}

# Azure AKS Name
output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.aks_cluster.name
}

# Azure AKS Version
output "aks_cluster_kubernetes_version" {
  value = azurerm_kubernetes_cluster.aks_cluster.kubernetes_version
}

# Azure VNET Name
output "aks_cluster_vnet_name" {
  value = azurerm_virtual_network.aksvnet.name
}

# Azure AKS Subnet  Name
output "aks_cluster_subnet_aks_name" {
  value = azurerm_subnet.aks-default.name
}

# Azure PRIV A Name
output "aks_cluster_subnet_priva_name" {
  value = azurerm_subnet.aks-priva.name
}

# Azure PUB A Name
output "aks_cluster_subnet_puba_name" {
  value = azurerm_subnet.aks-puba.name
}

# Azure APP_GW IP ID
output "appgw_public_ip_id" {
  value = azurerm_public_ip.appgw-pubip.id
}

# Azure WAF POLICY
output "appgw_wafpolicy" {
  value = azurerm_web_application_firewall_policy.appgw-wafpolicy.name
}

# Azure APP_GW ID
output "appgw_id" {
  value = azurerm_application_gateway.app_gw.id
}

# Azure KV NAME
output "key_vault_name" {
  value = azurerm_key_vault.key_vault.name
}
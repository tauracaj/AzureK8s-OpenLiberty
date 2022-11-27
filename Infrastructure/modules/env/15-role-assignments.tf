# Terraform Resource to Create Azure User Assigned Identity
resource "azurerm_role_assignment" "ra1" {
  scope                = data.azurerm_subnet.aks-subnet-source.id
  #scope                = azurerm_kubernetes_cluster.aks_cluster.identity[0].principal_id
  role_definition_name = "Network Contributor"
  principal_id         =  azurerm_user_assigned_identity.aks_identity.principal_id  #var.aks_service_principal_object_id

  depends_on = [azurerm_virtual_network.aksvnet]
}

resource "azurerm_role_assignment" "ra2" {
  scope                =  azurerm_user_assigned_identity.aks_identity.id
  role_definition_name = "Managed Identity Operator"
  principal_id         =  azurerm_user_assigned_identity.aks_identity.principal_id  #var.aks_service_principal_object_id

  depends_on           = [azurerm_user_assigned_identity.aks_identity]
}

resource "azurerm_role_assignment" "ra3" {
  scope                = azurerm_application_gateway.app_gw.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.aks_identity.principal_id

  depends_on           = [azurerm_user_assigned_identity.aks_identity, azurerm_application_gateway.app_gw]
}

resource "azurerm_role_assignment" "ra4" {
  scope                = azurerm_resource_group.aks_rg.id
  role_definition_name = "Reader"
  principal_id         = azurerm_user_assigned_identity.aks_identity.principal_id
   depends_on          = [azurerm_user_assigned_identity.aks_identity, azurerm_application_gateway.app_gw]
}

###TBR

resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                = var.acr_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_user_assigned_identity.aks_identity.principal_id
}

resource "azurerm_role_assignment" "aks_acr_push" {
  scope                = var.acr_id
  role_definition_name = "AcrPush"
  principal_id         = azurerm_user_assigned_identity.aks_identity.principal_id
}

resource "azurerm_role_assignment" "aks_acr_imagesigner" {
  scope                = var.acr_id
  role_definition_name = "AcrImageSigner"
  principal_id         = azurerm_user_assigned_identity.aks_identity.principal_id
}

resource "azurerm_role_assignment" "aks_monitoring_metrics_publisher" {
  scope                = azurerm_kubernetes_cluster.aks_cluster.id
  role_definition_name = "Monitoring Metrics Publisher"
  principal_id         = azurerm_user_assigned_identity.aks_identity.principal_id #azurerm_kubernetes_cluster.aks_cluster.identity[0].principal_id
}

resource "azurerm_role_assignment" "attach_acr" {

  scope                = var.acr_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks_cluster.kubelet_identity[0].object_id
}
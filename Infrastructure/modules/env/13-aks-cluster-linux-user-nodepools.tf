# Create Linux Azure AKS Node Pool
resource "azurerm_kubernetes_cluster_node_pool" "linux101" {
  zones                 = [1, 2, 3]
  enable_auto_scaling   = true
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks_cluster.id
  max_count             = 3
  min_count             = 1
  mode                  = var.nodepool_type_user
  name                  = var.lin_nodepool_name
  orchestrator_version  = data.azurerm_kubernetes_service_versions.current.latest_version
  os_disk_size_gb       = 30
  os_type               = "Linux" # Default is Linux, we can change to Windows
  vm_size               = var.lin_nodepool_vm_size
  priority              = "Regular" # Default is Regular, we can change to Spot with additional settings like eviction_policy, spot_max_price, node_labels and node_taints
  vnet_subnet_id        = azurerm_subnet.aks-default.id
  node_labels = {
    "nodepool-type" = var.nodepool_type_user
    "environment"   = var.environment
    "nodepools"     = var.lin_nodepool_os
    "app"           = var.lin_nodepool_app
  }
  tags = {
    "nodepool-type" = var.nodepool_type_user
    "environment"   = var.environment
    "nodepools"     = var.lin_nodepool_os
    "app"           = var.lin_nodepool_app
  }
}
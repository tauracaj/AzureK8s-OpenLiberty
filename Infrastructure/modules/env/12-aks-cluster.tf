# Provision AKS Cluster
/*
1. Add Basic Cluster Settings
  - Get Latest Kubernetes Version from datasource (kubernetes_version)
  - Add Node Resource Group (node_resource_group)
2. Add Default Node Pool Settings
  - orchestrator_version (latest kubernetes version using datasource)
  - availability_zones
  - enable_auto_scaling
  - max_count, min_count
  - os_disk_size_gb
  - type
  - node_labels
  - tags
3. Enable MSI
4. Add On Profiles 
  - Azure Policy
  - Azure Monitor (Reference Log Analytics Workspace id)
5. RBAC & Azure AD Integration
6. Admin Profiles
  - Linux Profile
7. Network Profile
8. Cluster Tags  
*/

#Create Cluster
resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = "${var.aks_name}-${var.environment}"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  dns_prefix          = "${var.aks_name}-${var.environment}"
  kubernetes_version  = data.azurerm_kubernetes_service_versions.current.latest_version
  node_resource_group = "${azurerm_resource_group.aks_rg.name}-nrg"
  azure_policy_enabled              = true
  role_based_access_control_enabled = true
  ingress_application_gateway {
      gateway_id = azurerm_application_gateway.app_gw.id
    }

  default_node_pool {
    name = "systempool"
    #node_count = 1
    vm_size              = "Standard_D2_v2"
    orchestrator_version = data.azurerm_kubernetes_service_versions.current.latest_version
    zones                = [1, 2, 3]
    enable_auto_scaling  = true
    min_count            = 1
    max_count            = 3
    os_disk_size_gb      = 40
    type                 = "VirtualMachineScaleSets"
    vnet_subnet_id       = azurerm_subnet.aks-default.id
    node_labels = {
      "nodepool-type" = "${var.nodepool_type_system}"
      "environment"   = "${var.environment}"
      "nodepool"      = "${var.nodepool_name}"
      "app"           = "${var.nodepool_app}"
    }
    tags = {
      "nodepool-type" = "${var.nodepool_type_system}"
      "environment"   = "${var.environment}"
      "nodepoolos"    = "${var.nodepool_name}"
      "app"           = "${var.nodepool_app}"
    }
  }

  identity {
    type         = var.aks_umi_type
    identity_ids = [azurerm_user_assigned_identity.aks_identity.id]
  }

  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.loganalytic.id
  }

  key_vault_secrets_provider {
    secret_rotation_enabled = true
  }

  azure_active_directory_role_based_access_control {
    managed                = true
    admin_group_object_ids = [azuread_group.aks_administrators.object_id]
  }


  # Windows Profile
  /*windows_profile {
    admin_username = var.windows_admin_username
    admin_password = var.windows_admin_password
  }*/

  #Linux Profile
  linux_profile {
    admin_username = var.linux_admin_username
    ssh_key {
      key_data = var.ssh_public_key #file(var.ssh_public_key) 
    }
  }

  # Network Profile
  network_profile {
    network_plugin    = var.aks_network_profile_plugin
    load_balancer_sku = var.aks_network_profile_lb_sku
  }
  
  tags = {
    Environment = var.environment
  }
}
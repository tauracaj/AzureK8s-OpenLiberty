# https://www.terraform.io/docs/configuration/variables.html
# Input Variables
# Output Values
# Local Values (Optional)

# Define Input Variables
# 1. Azure Location (NorthEurope)
# 2. Azure Resource Group Name 
# 3. Azure AKS Environment Name (Dev, QA, Prod)

variable "subscription_id" {
  default = ""
}
variable "client_id" {
  default = ""
}
variable "client_secret" {
  default = ""
}
variable "tenant_id" {
  default = ""
}

# Azure Location
variable "location" {
  default     = "North Europe"
  description = "Azure Region where all resources will be created"
  type        = string
}

# Azure Resource Group Name
variable "resource_group_name" {
  default     = "ne-aks-rg"
  description = "This defines RG name"
  type        = string
}

# Azure AKS Environment Name
variable "environment" {
  default     = "stag"
  description = "This is Environment var"
  type        = string
}

# Azure kubernetes cluster
variable "aks_name" {
  default     = "ne-aks"
  description = "This defines AKS name"
  type        = string
}

variable "name_prefix" {
  description = "prefix used in naming"
  type        = string
  default     = ""
}

# Azure kubernetes cluster useridentity type
variable "aks_umi_type" {
  default     = "UserAssigned"
  description = "This defines AKS name"
  type        = string
}

# Azure Owner
variable "owner" {
  default     = "TR"
  description = "This is Owner var"
  type        = string
}

#Azure Department
variable "department" {
  default     = "IT"
  description = "This is department where the resource is assigned"
  type        = string
}

# SSH Public Key for Linux VMs
variable "ssh_public_key" {
  default = "~/.ssh/aks-prod-sshkeys-terraform/aksprodsshkey.pub"
  description = "This variable defines the SSH Public Key for Linux k8s Worker nodes"
}

# Linux Admin Username for k8s
variable "linux_admin_username" {
  type        = string
  default     = "linuser"
  description = "This variable defines the Linux admin username k8s"
}

# Windows Admin Username for k8s worker nodes
variable "windows_admin_username" {
  type        = string
  default     = "winuser"
  description = "This variable defines the Windows admin username k8s Worker nodes"
}

# Windows Admin Password for k8s worker nodes
variable "windows_admin_password" {
  type        = string
  default     = "P@ssw0rd1#2!!!#"
  description = "This variable defines the Windows admin password k8s Worker nodes"
}


# Node Pool Label/TAG Type
variable "nodepool_type_system" {
  type        = string
  default     = "system"
  description = "This Variable defines node pool label/tag type"
}

# Node Pool Label/TAG NAME
variable "nodepool_name" {
  type        = string
  default     = "linux"
  description = "This Variable defines node pool label/tag name"
}


# Node Pool Label/TAG App
variable "nodepool_app" {
  type        = string
  default     = "system-apps"
  description = "This Variable defines node pool label/tag app"
}

# Aks Network Profile type
/*Options:
    1. azure
    2. kubenet
    3.none
*/
variable "aks_network_profile_plugin" {
  type        = string
  default     = "azure"
  description = "This Variable defines Network Profile plugin type"
}


# Aks Network Profile load balancer
/*Options:
    1. basic
    2. standard
*/
variable "aks_network_profile_lb_sku" {
  type        = string
  default     = "standard"
  description = "This Variable defines etwork Profile load balancer sku"
}


#NodePoolLinux

# User Node Pool Name
variable "lin_nodepool_name" {
  type        = string
  default     = "linux101"
  description = "This Variable defines node pool linux"
}


variable "nodepool_type_user" {
  type        = string
  default     = "User"
  description = "This Variable defines node pool linux type"
}


variable "lin_nodepool_vm_size" {
  type        = string
  default     = "Standard_DS2_v2"
  description = "This Variable defines node pool  size"
}

variable "lin_nodepool_app" {
  type        = string
  default     = "java-apps"
  description = "This Variable defines node pool app"
}

variable "lin_nodepool_os" {
  type        = string
  default     = "Linux"
  description = "This Variable defines node pool os"
}

#Windows pool

# User Node Pool Name
variable "win_nodepool_name" {
  type        = string
  default     = "win101"
  description = "This Variable defines node pool windows"
}

variable "win_nodepool_vm_size" {
  type        = string
  default     = "Standard_DS2_v2"
  description = "This Variable defines node pool  size"
}

variable "win_nodepool_app" {
  type        = string
  default     = "dotnet-apps"
  description = "This Variable defines node pool app"
}

variable "win_nodepool_os" {
  type        = string
  default     = "Windows"
  description = "This Variable defines node pool os"
}

variable "networkrule" {
  default     = []
}

variable "networkruleappgw" {
  default     = []
}

variable "address_space" {

}

variable "acr_id" {
  type        = string
}

variable "appgw_name" {
  default     = "appgw"
  type        = string
  description = "This Variable defines appgw name"
}

variable "appgw_sku_capacity" {
  description = "Application gateway's SKU capacity"
  type        = string
  default     = 2
}

variable "appgw_sku_name" {
  description = "Application gateway's SKU name"
  type        = string
  default     = "WAF_v2"
}

variable "appgw_zones" {
  description = "Application gateway's Zones to use"
  type        = list(string)
  default     = ["1", "2", "3"]
}

variable "appgw_sku_tier" {
  description = "Application gateway's SKU tier"
  type        = string
  default     = "WAF_v2"
}

variable "appgw_public_ip_allocation_method" {
  type        = string
  default     = "Static"
  description = "This Variable defines appgw ip allocation method"
}

/*variable "appgw_frontend_ip_configuration_name" {
  description = "Name of the appgw frontend ip configuration"
  type        = string
}*/

variable "appgw_frontend_port_name" {
  type        = string
  default     = "Port80"
  description = "This Variable defines appgw ip frontend port name"
}

variable "appgw_ip_configuration_name" {
  description = "Name of the appgw gateway ip configuration"
  default     = "IPConfig"
  type        = string
}

variable "appgw_backend_address_pool_name" {
  type        = string
  default     = "BackendPool"
  description = "This Variable defines appgw ip backend pool"
}

variable "appgw_public_ip_sku" {
  type        = string
  default     = "Standard"
  description = "This Variable defines appgw ip Sku-Possible values: Standard and Basic"
}

# Azure Key Vault
variable "key_vault" {
  default     = "vault"
  description = "This defines key vault name"
  type        = string
}

# We will define 
# 1. Terraform Settings Block
# 1. Required Version Terraform
# 2. Required Terraform Providers
# 3. Terraform Remote State Storage with Azure Storage Account (last step of this section)
# 2. Terraform Provider Block for AzureRM
# 3. Terraform Resource Block: Define a Random Pet Resource

terraform {
  # 1. Required Version Terraform
  required_version = "~> 1.0"
  # 2. Required Terraform Providers
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
  # Configure Terraform State Storage
  backend "azurerm" {
    resource_group_name  = "Default"
    storage_account_name = "scdeploymentstoragetau"
    container_name       = "tfstatefiles"
    key                  = "tst.terraform.tfstate"
  }
}

# 2. Terraform Provider Block for Azure
provider "azurerm" {
  #subscription_id =     var.subscription_id
  #client_id       =     var.client_id
  #client_secret   =     var.client_secret
  #tenant_id       =     var.tenant_id
  features {}
}

# 3. Terraform Resource Block: Define a Random Pet Resource
resource "random_pet" "aksrandom" {

}

data "azurerm_client_config" "current" {}

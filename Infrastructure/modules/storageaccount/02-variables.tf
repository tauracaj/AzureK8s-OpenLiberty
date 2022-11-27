# https://www.terraform.io/docs/configuration/variables.html
# Input Variables
# Output Values
# Local Values (Optional)

# Define Input Variables
# 1. Azure Location (CentralUS)
# 2. Azure Resource Group Name 


# Azure Location
variable "location" {
  default = "North Europe"
  description = "Azure Region where all resources will be created"
  type = string
}

# Azure Resource Group Name
variable "resource_group_name" {
  default = "ne-sa-rg"
  description = "This defines RG name"
  type = string
}

# Azure AKS Environment Name
variable "environment" {
  #default = "test"
  description = "This is Environment var"
  type = string
}


# Azure Storage account name
variable "storagename" {
  default = "stracc"
  description = "Azure Storage account"
  type = string
}
# Azure Storage account type
variable "storagetype" {
  default = "GRS"
  description = "Azure Storage account type"
  type = string
}

# Azure Storage account tier
variable "storagetier" {
  default = "Standard"
  description = "Azure Storage account tier"
  type = string
}

# Azure Storage account container name
variable "storagecontainer" {
  default = "tfsstatecontainer"
  description = "Azure Storage account containername"
  type = string
}

#variable "storagetags" {
#  type = map
#  default = { enviornment = "demo", owner = "tr", purpose = "demo" }
#}

# Azure Owner
variable "owner" {
  default = "TR"
  description = "This is Owner var"
  type = string
}

#Azure Department
variable "department" {
  default = "IT"
  description = "This is department where the resource is assigned"
  type = string
}

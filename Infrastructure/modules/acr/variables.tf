# https://www.terraform.io/docs/configuration/variables.html
# Input Variables
# Output Values
# Local Values (Optional)

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
  default     = "ne-global-rg"
  description = "This defines RG name"
  type        = string
}

# Azure AKS Environment Name
variable "environment" {
  default     = "stag"
  description = "This is Environment var"
  type        = string
}

# ACR name
variable "acr_name" {
  default     = "cr"
  description = "This defines ACR name"
  type        = string
}

# ACR SKU
variable "acr_sku" {
  default     = "Basic"
  description = "This defines AKS sku: Options: Basic, Standard and Premium"
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
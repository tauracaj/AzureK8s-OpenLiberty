locals {
  environment = "tst"
  location = "North Europe"
}


module "acr" {
  source                   = "../../modules/acr"
  environment              = local.environment
  location                 = local.location         
}

module "env" {
  source = "../../modules/env"

  acr_id                   = module.acr.acr_id
  environment              = local.environment   
  ssh_public_key           = var.ssh_public_key       
  
  #address space {VNET_SPACE, GATEWAY_SUBNET, PRIVA_SUBNET, PUBA_SUBNET, BASTION_SUBNET, AKS_SUBNET}
  address_space = ["172.20.0.0/16","172.20.16.0/27","172.20.17.0/24","172.20.18.0/24","172.20.19.0/24","172.20.24.0/21"] 
  location = local.location
  
  #example on how to addd network rule
  networkruleappgw = [
    {
      name                       = "Internet"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "65200-65535"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "test123"
      priority                   = 101
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    } 
  ]
  networkrule = [
    {
      name                       = "test123"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }  
  ]   
}


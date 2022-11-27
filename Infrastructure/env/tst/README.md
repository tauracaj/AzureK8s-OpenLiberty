# Create Environment

## Step-00: Prerequisites
- Create Azure DevOps Pipeline to create AKS cluster using Terraform
- Provision Test AKS Cluster with ACR

## Step-01: Review Terraform Manifests
### 01-main.tf
- Setup Locals
- Initiate Module ACR
- Initiate Module ENV


## Step-02: Review Terraform Manifests
### 02-providers.tf
- Required providers
- Configure backed - Storage account where the tfstate will live

## Step-03: Outputs
### 03-outputs.tf 
- Output values
- Resource Group AKS
  - Name
- AKS Cluster 
  - Name

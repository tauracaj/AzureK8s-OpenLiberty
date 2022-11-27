# Module Storage Account

## Note
- This Module is created for the purpose of tf state.

## Step-01: Main
### 01-main.tf
- required_providers setup

## Step-02: Variables
### 02-variables.tf
Important note: Minimum required variables to be set are:


Full Variable List

| Name | Type | Description |
|------|--------|---------|
| location | string | Azure Region where all resources will be created |
| resource_group_name | string | Name of Resource group |
| environment | string | Name of Environment |
| storagename | string | This defines Storage Account name |
| storagetype | string | This defines Storage Account type. Possible values: GRS, LRS ... |
| storagetier | string | Azure Storage account tier |
| storagecontainer | string | Azure Storage account containername |
| owner | string | Azure Storage account containername |
| storagecontainer | string | Azure Storage account containername |
| owner | string | This is a variable used for TAG |
| department | string | This is a variable used for TAG |

## Step-03: Resource groups
### 03-resource-group.tf
- Creates a Resource group for AKS azurerm_resource_group 

## Step-04:  Storage Account
### 04-storage-account
- Create Storage Account 
- Create Storage Account Container

## Step-05: Outputs
### 05-outputs.tf  
- The output variables can be used when the module is executed standalone
- So when called from a root the output variables needs to be defined in the root.

- Output values
- Resource Group 
  - Location
  - Name
  - ID
  - Tags
- Storage Account Name 
  - Name
  - ID
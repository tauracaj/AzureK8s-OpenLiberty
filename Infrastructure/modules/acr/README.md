
## Module ACR: Create ACR
### 01-container_registry.tf
- Creates a Resource group for ACR azurerm_resource_group
- Creates Azure Container Registry on dedicated Resource group

### 02-variables.tf

| Name | Type | Description |
|------|--------|---------|
| location | string | Azure Region where all resources will be created |
| resource_group_name | string | Name of Resource group |
| environment | string | Name of Environment |
| acr_sku | string | This defines AKS sku: Options: Basic, Standard and Premium |
| owner | string | This is a variable used for TAG |
| department | string | This is a variable used for TAG |

### 03-outputstf
- The output variables can be used when the module is executed standalone
- So when called from a root the output variables needs to be defined in the root.

| Name | Description |
|------|---------|
| location | Value of Resource group location |
| resource_group_id | Value of Resource group location |
| resource_group_name | Value of Resource group name |
| resource_group_tags | Value of Resource group tags |
| acr_name | Value of acr name |
| acr_id | Value of acr id |
| container_registery_uri | Value of acr url |
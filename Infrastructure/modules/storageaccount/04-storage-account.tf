# Terraform Resource to Create Azure Storage Account

resource "azurerm_storage_account" "storage_acc" {
  name                     = "${var.storagename}${var.environment}"
  resource_group_name      = azurerm_resource_group.sa_rg.name
  location                 = azurerm_resource_group.sa_rg.location
  account_tier             = var.storagetier
  account_replication_type = var.storagetype

   # Add Tags
  tags = {
    "environment" = "${var.environment}"
    "owner"     = "${var.owner}"
    "department"  = "${var.department}"
  }
}

resource "azurerm_storage_container" "storage_acc_cnt" {
  count                 = 1
  name                  = "${var.storagecontainer}${count.index}"
  storage_account_name  = azurerm_storage_account.storage_acc.name
  container_access_type = "private"
}

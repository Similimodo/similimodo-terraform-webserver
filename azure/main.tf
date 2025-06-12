resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = var.resource_group_name
}

# create a storage account
resource "azurerm_storage_account" "azurestorage" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.resource_group_location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  account_kind             = "StorageV2"

  tags = {
    environment = "terraform"
  }
  static_website {
    index_document = var.index_document
  }
}

# resource "azurerm_storage_blob" "blooob" {
#   name                   = var.index_document
#   storage_account_name   = var.storage_account_name
#   storage_container_name = "$web"
#   type                   = "Block"
#   source_content         = var.source_content
#   content_type           = "text/html"
# }



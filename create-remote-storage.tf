# resource "azurerm_resource_group" "tfstate" {
#   name     = "rg-tfstate-${var.environment}-${var.region}-001"
#   location = var.location
# }

# resource "azurerm_storage_account" "tfstate" {
#   name                            = "sttfstate${var.environment}${var.region}001"
#   resource_group_name             = azurerm_resource_group.tfstate.name
#   location                        = azurerm_resource_group.tfstate.location
#   account_tier                    = "Standard"
#   account_replication_type        = "LRS"
#   allow_nested_items_to_be_public = false

#   tags = {
#     environment = "staging"
#   }
# }

# resource "azurerm_storage_container" "tfstate" {
#   name                  = "tfstate"
#   storage_account_id    = azurerm_storage_account.tfstate.id
#   container_access_type = "private"
# }
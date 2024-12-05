# CosmosDB account
resource "azurerm_cosmosdb_account" "cdb" {
  location            = azurerm_resource_group.rg-cosmosdb.location
  name                = var.cosmosdb-account-name
  offer_type          = "Standard"
  resource_group_name = azurerm_resource_group.rg-cosmosdb.name

  capabilities {
    name = "EnableServerless"
  }
  capabilities {
    name = "EnableTable"
  }
  consistency_policy {
    consistency_level = "BoundedStaleness"
  }
  geo_location {
    failover_priority = 0
    location          = azurerm_resource_group.rg-cosmosdb.location
  }
}

# CosmosDB table
resource "azurerm_cosmosdb_table" "cdb_table" {
  account_name        = azurerm_cosmosdb_account.cdb.name
  name                = var.cosmosdb-table-name
  resource_group_name = azurerm_resource_group.rg-cosmosdb.name
}
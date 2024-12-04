# CosmosDB account
resource "azurerm_cosmosdb_account" "cdb" {
  location            = azurerm_resource_group.rg-cosmosdb.location
  name                = "cosmosdb-api-test-v1"
  offer_type          = "Standard"
  resource_group_name = azurerm_resource_group.rg-cosmosdb.name
  tags = {
    defaultExperience       = "Azure Table"
    hidden-cosmos-mmspecial = ""
  }
  analytical_storage {
    schema_type = "WellDefined"
  }
  backup {
    storage_redundancy  = "Local"
    type                = "Periodic"
    interval_in_minutes = 240
    retention_in_hours  = 8
  }
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
  name                = "Visitor_Counter"
  resource_group_name = azurerm_resource_group.rg-cosmosdb.name
}
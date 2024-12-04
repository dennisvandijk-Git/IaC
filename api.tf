# Storage account
resource "azurerm_storage_account" "sa-api" {
  name                     = "linuxfunctionappsav1"
  resource_group_name      = azurerm_resource_group.rg-api.name
  location                 = azurerm_resource_group.rg-api.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# App Service plan
resource "azurerm_service_plan" "sp" {
  name                = "api-app-service-plan"
  resource_group_name = azurerm_resource_group.rg-api.name
  location            = azurerm_resource_group.rg-api.location
  os_type             = "Linux"
  sku_name            = "Y1" # Y1 = a function consumption plan
}

# Function App
resource "azurerm_linux_function_app" "lfa" {
  name                = "api-linux-function-app"
  resource_group_name = azurerm_resource_group.rg-api.name
  location            = azurerm_resource_group.rg-api.location

  storage_account_name       = azurerm_storage_account.sa-api.name
  storage_account_access_key = azurerm_storage_account.sa-api.primary_access_key
  service_plan_id            = azurerm_service_plan.sp.id

  site_config {
    cors {
      allowed_origins = ["https://www.dvandijk.com", "https://dev.dvandijk.com"]
    }
    application_stack {
      python_version = 3.11
    }
  }
  app_settings = {
    "COSMOSDB_CONNECTION_STRING" = local.COSMOSDB_CONNECTION_STRING
  }
}

# Log Analytics workspace
resource "azurerm_log_analytics_workspace" "law" {
  location            = azurerm_resource_group.rg-api.location
  name                = azurerm_storage_account.sa-api.name
  resource_group_name = azurerm_resource_group.rg-api.name
}

# Action group
resource "azurerm_monitor_action_group" "mag" {
  location            = "global"
  name                = "Application Insights Smart Detection"
  resource_group_name = azurerm_resource_group.rg-api.name
  short_name          = "SmartDetect"

  email_receiver {
    email_address           = "dennisvandijk91@live.nl"
    name                    = "Notify_-EmailAction-"
    use_common_alert_schema = true
  }
}

# Application Insights
resource "azurerm_application_insights" "ai" {
  name                = azurerm_storage_account.sa-api.name
  location            = azurerm_resource_group.rg-api.location
  resource_group_name = azurerm_resource_group.rg-api.name
  application_type    = "web"
  workspace_id        = azurerm_log_analytics_workspace.law.id
}
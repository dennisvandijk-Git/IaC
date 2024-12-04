variable "location" {
  type = string
}

variable "subscription-dev" {
  type = string
}

variable "dev" {
  type = string
}

variable "function-name" {
  type = string
}

variable "CLOUDFLARE_API_TOKEN" {
  type = string
}

variable "CLOUDFLARE_ZONE_ID" {
  type = string
}

locals {
  COSMOSDB_CONNECTION_STRING = format("DefaultEndpointsProtocol=https;AccountName=%s;AccountKey=%s;TableEndpoint=https://${azurerm_cosmosdb_account.cdb.name}.table.cosmos.azure.com:443/",
    azurerm_cosmosdb_account.cdb.name,
    azurerm_cosmosdb_account.cdb.primary_key
  )
}

locals {
  FUNTION_API_URL = format("https://%s.azurewebsites.net/api/${var.function-name}",
    azurerm_linux_function_app.lfa.name
  )
}

# locals {
#   FUNTION_API_URL = format("https://${azurerm_linux_function_app.lfa.name}.azurewebsites.net/api/${var.function-name}")
# }

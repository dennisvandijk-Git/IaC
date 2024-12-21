# General
variable "location" {
  type = string
}

variable "subscription-dev" {
  type = string
}

variable "environment" {
  type = string
}

variable "region" {
  type = string
}

variable "MAIL" {
  type = string
}

variable "function-name" {
  type = string
}

# CosmosDB
variable "cosmosdb-account-name" {
  type = string
}

variable "cosmosdb-table-name" {
  type = string
}

# API
variable "api-st-name" {
  type = string
}

variable "api-asp-name" {
  type = string
}

variable "api-lfa-name" {
  type = string
}

# Website
variable "static-sa-name" {
  type = string
}
variable "static-cdn-profile-name" {
  type = string
}
variable "static-cdn-endpoint-name" {
  type = string
}

variable "static-custom-domain-name" {
  type = string
}

variable "static-custom-domain-hostname" {
  type = string
}

# Cloudflare
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
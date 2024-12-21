# Storage account
resource "azurerm_storage_account" "sa-sw" {
  account_kind             = "StorageV2"
  account_replication_type = "LRS"
  account_tier             = "Standard"
  location                 = azurerm_resource_group.rg-website.location
  name                     = var.static-sa-name
  resource_group_name      = azurerm_resource_group.rg-website.name
}

# Static website
resource "azurerm_storage_account_static_website" "sa-static-website" {
  storage_account_id = azurerm_storage_account.sa-sw.id
  error_404_document = "404.html"
  index_document     = "index.html"
}

# CDN profile
resource "azurerm_cdn_profile" "cdn-profile" {
  location            = "global"
  name                = var.static-cdn-profile-name
  resource_group_name = azurerm_resource_group.rg-website.name
  sku                 = "Standard_Microsoft"
}

# CDN endpoint
resource "azurerm_cdn_endpoint" "cdn-endpoint" {
  location            = azurerm_cdn_profile.cdn-profile.location
  name                = var.static-cdn-endpoint-name
  optimization_type   = "GeneralWebDelivery"
  origin_host_header  = replace(replace(azurerm_storage_account.sa-sw.primary_web_endpoint, "https://", ""), "/", "")
  profile_name        = azurerm_cdn_profile.cdn-profile.name
  resource_group_name = azurerm_resource_group.rg-website.name
  origin {
    host_name = replace(replace(azurerm_storage_account.sa-sw.primary_web_endpoint, "https://", ""), "/", "")
    name      = "dvandijk-resume"
  }
}

# CDN custom domain
resource "azurerm_cdn_endpoint_custom_domain" "cdn-customdomain" {
  name            = var.static-custom-domain-name
  cdn_endpoint_id = azurerm_cdn_endpoint.cdn-endpoint.id
  host_name       = var.static-custom-domain-hostname

  cdn_managed_https {
    certificate_type = "Dedicated"
    protocol_type    = "ServerNameIndication"
    tls_version      = "TLS12"
  }
}
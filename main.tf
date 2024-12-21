# Static website Resource group
resource "azurerm_resource_group" "rg-website" {
  location = var.location
  name     = "rg-website-${var.environment}-${var.region}-001"
}

# API Resource group
resource "azurerm_resource_group" "rg-api" {
  location = var.location
  name     = "rg-api-${var.environment}-${var.region}-001"
}

# CosmosDB Resource group
resource "azurerm_resource_group" "rg-cosmosdb" {
  location = var.location
  name     = "rg-cosmosdb-${var.environment}-${var.region}-001"
}

# Create a DNS record
resource "cloudflare_dns_record" "dnsr-dennisvandijk-dev" {
  zone_id = var.CLOUDFLARE_ZONE_ID
  name    = var.environment
  content = "${var.environment}-dennisvandijk.azureedge.net"
  type    = "CNAME"
  ttl     = 1 # auto
  proxied = false
}

resource "time_sleep" "wait_60_seconds" {
  depends_on       = [azurerm_cdn_endpoint_custom_domain.cdn-customdomain]
  destroy_duration = "60s"
}
# Static website Resource group
resource "azurerm_resource_group" "rg-staticwebsite" {
  location = var.location
  name     = "${var.dev}staticwebsite-rg"
}

# API Resource group
resource "azurerm_resource_group" "rg-api" {
  location = var.location
  name     = "${var.dev}api-rg"
}

# CosmosDB Resource group
resource "azurerm_resource_group" "rg-cosmosdb" {
  location = var.location
  name     = "${var.dev}cosmosdb-rg"
}

# Create a DNS record
resource "cloudflare_dns_record" "dnsr-dev-dennisvandijk" {
  zone_id = var.CLOUDFLARE_ZONE_ID
  name    = "dev"
  content = "dev-dennisvandijk.azureedge.net"
  type    = "CNAME"
  ttl     = 1 # auto
  proxied = false
}

resource "time_sleep" "wait_60_seconds" {
  depends_on       = [cloudflare_dns_record.dnsr-dev-dennisvandijk]
  destroy_duration = "60s"
}
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
  ttl     = 1
  proxied = false
}

# # Local env file
# resource "local_file" "outputs" {
#   content = <<EOT
# FUNCTION_API_URL="${local.FUNTION_API_URLV1}"
# COSMOSDB_CONNECTION_STRING="${local.COSMOSDB_CONNECTION_STRING}"
# EOT
#   filename = "C:/Users/denni/OneDrive/Documenten/GitHub/terraform_outputs.env"
# }

# resource "local_file" "config_json" {
#   filename = "C:/Users/denni/OneDrive/Documenten/GitHub/CloudResumeChallenge/config.json"
#   content = jsonencode({
#     FUNCTION_API_URL = local.FUNTION_API_URLV1
#   })
# }
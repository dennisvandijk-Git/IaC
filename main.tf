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

data "azurerm_key_vault_secret" "func-secret" {
  # name = "AZURE-FUNCTIONAPP-NAME"
  name = "test"
  key_vault_id = "/subscriptions/fb6085da-feae-4a43-ae4f-2352d9707ee9/resourceGroups/dev-keyvault-rg/providers/Microsoft.KeyVault/vaults/dev-keyvault-dvd"
}

output "secret_value" {
  value = data.azurerm_key_vault_secret.func-secret.value
  sensitive = true
}

# data "azurerm_key_vault" "key-vault" {
#    name = "dev-keyvault-dvd"
#    resource_group_name = "dev-keyvault-rg"
# }

# output "key_vault_id" {
#   value = data.azurerm_key_vault.key-vault.id
# }

# output "key_vault_location" {
#   value = data.azurerm_key_vault.key-vault.location
# }

# data "azurerm_key_vault_secrets" "name" {
#   key_vault_id = "/subscriptions/fb6085da-feae-4a43-ae4f-2352d9707ee9/resourceGroups/dev-keyvault-rg/providers/Microsoft.KeyVault/vaults/dev-keyvault-dvd"
# }

# output "key_vault_secrets" {
#   value = data.azurerm_key_vault_secrets.name
# }


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
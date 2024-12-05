# output "COSMOSDB_CONNECTION_STRING" {
#   value = format("DefaultEndpointsProtocol=https;AccountName=%s;AccountKey=%s;TableEndpoint=https://${azurerm_cosmosdb_account.cdb.name}.table.cosmos.azure.com:443/",
#     azurerm_cosmosdb_account.cdb.name,
#     azurerm_cosmosdb_account.cdb.primary_key
#   )
#   sensitive = true
# }

# output "FUNCTION_API_URL" {
#   value = format("https://%s.azurewebsites.net/api/${var.function-name}",
#     azurerm_linux_function_app.lfa.name
#   )
#   sensitive = true
# }

# output "api-url" {
#   value     = azurerm_function_app_function.faf.invocation_url
#   sensitive = true
# }

# output "url-api" {
#   value     = local.FUNTION_API_URL
#   sensitive = true
# }


# General
location         = "westeurope"
subscription-dev = "fb6085da-feae-4a43-ae4f-2352d9707ee9"
environment      = "dev"
region           = "westeu"
function-name    = "visitor_counter"

# CosmosDB
cosmosdb-account-name = "costab-api-${var.environment}"
cosmosdb-table-name   = "Visitor_Counter"

# API
api-st-name  = "stapi${var.environment}001"
api-asp-name = "asp-api-${var.environment}-001"
api-lfa-name = "func-api-${var.environment}-001.azurewebsites.net"

# Website
static-sa-name                = "stwebsite${var.environment}001"
static-cdn-profile-name       = "cdnp-website-${var.environment}-001"
static-cdn-endpoint-name      = "cdne-website-${var.environment}-001"
static-custom-domain-name     = "dvandijk"
static-custom-domain-hostname = "dev.dvandijk.com"
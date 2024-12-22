# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "5.0.0-alpha1"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-tfstate-dev-westeu-001"
    storage_account_name = "sttfstatedevwesteu001"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  subscription_id = var.subscription-dev
  features {

  }

}

provider "cloudflare" {
  api_token = var.CLOUDFLARE_API_TOKEN
}

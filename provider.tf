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
    resource_group_name = "dev-tfstate-rg"
    storage_account_name = "stdevweutfstate"
    container_name = "tfstate"
    key = "terraform.tfstate"
  }
}

provider "azurerm" {
  subscription_id = "fb6085da-feae-4a43-ae4f-2352d9707ee9"
  features {

  }

}

provider "cloudflare" {
  api_token = var.CLOUDFLARE_API_TOKEN
}

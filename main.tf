terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# 1. Create a Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "rg-nohello-static-site"
  location = "East US"
}

# 2. Create a Storage Account
resource "azurerm_storage_account" "sa" {
  name                     = "stnohellostaticlecanuus"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"

  static_website {
    index_document = "index.html"
    error_404_document = "404.html" # You may need to create a 404.html file
  }
}

# 3. Enable Custom Domain
resource "azurerm_storage_account_custom_domain" "custom_domain" {
  storage_account_id = azurerm_storage_account.sa.id
  domain_name        = "lecanu.us"
}
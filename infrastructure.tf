
variable "ARM_CLIENT_ID" {

}

variable "ARM_CLIENT_SECRET" {

}

variable "ARM_TENANT_ID" {

}

variable "ARM_SUBSCRIPTION_ID" {

}

variable "imagetag" {
  type        = string
  description = "Latest build using the latest image tag."
}


terraform {

  backend "azurerm" {}

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.91.0"
    }
  }

}




provider "azurerm" {
  features {}
  subscription_id = var.ARM_SUBSCRIPTION_ID
  client_id       = var.ARM_CLIENT_ID
  client_secret   = var.ARM_CLIENT_SECRET
  tenant_id       = var.ARM_TENANT_ID
}

resource "azurerm_resource_group" "local-terraform-rg" {
  name     = "terraform-rg"
  location = "uaenorth"
}

resource "azurerm_container_group" "local-container-group" {
  name                = "api-container"
  location            = azurerm_resource_group.local-terraform-rg.location
  resource_group_name = azurerm_resource_group.local-terraform-rg.name
  ip_address_type     = "public"
  dns_name_label      = "iac-api"
  os_type             = "Linux"

  container {
    name   = "api-container"
    image  = "tashikmoin/iac:${var.imagetag}"
    cpu    = 1
    memory = 1
    ports {
      port     = 80
      protocol = "TCP"
    }
  }
}


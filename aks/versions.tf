terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.51.0"
    }
  }

  required_version = "~> 1.4.4"
}

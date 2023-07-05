terraform {
  required_providers {
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0.4"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.51.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "2.9.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.19.0"
    }

    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }

  required_version = "~> 1.4.4"
}

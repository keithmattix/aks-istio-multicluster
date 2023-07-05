provider "tls" {}

provider "azurerm" {
  features {}
}

provider "helm" {
  alias = "cluster1"
  kubernetes {
    host                   = data.azurerm_kubernetes_cluster.cluster1.kube_config.0.host
    client_certificate     = base64decode(data.azurerm_kubernetes_cluster.cluster1.kube_config.0.client_certificate)
    client_key             = base64decode(data.azurerm_kubernetes_cluster.cluster1.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.cluster1.kube_config.0.cluster_ca_certificate)
  }
}

provider "kubernetes" {
  alias                  = "cluster1"
  host                   = data.azurerm_kubernetes_cluster.cluster1.kube_config.0.host
  client_certificate     = base64decode(data.azurerm_kubernetes_cluster.cluster1.kube_config.0.client_certificate)
  client_key             = base64decode(data.azurerm_kubernetes_cluster.cluster1.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.cluster1.kube_config.0.cluster_ca_certificate)
}

provider "kubectl" {
  alias                  = "cluster1"
  host                   = data.azurerm_kubernetes_cluster.cluster1.kube_config.0.host
  client_certificate     = base64decode(data.azurerm_kubernetes_cluster.cluster1.kube_config.0.client_certificate)
  client_key             = base64decode(data.azurerm_kubernetes_cluster.cluster1.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.cluster1.kube_config.0.cluster_ca_certificate)
}

provider "helm" {
  alias = "cluster2"
  kubernetes {
    host                   = data.azurerm_kubernetes_cluster.cluster2.kube_config.0.host
    client_certificate     = base64decode(data.azurerm_kubernetes_cluster.cluster2.kube_config.0.client_certificate)
    client_key             = base64decode(data.azurerm_kubernetes_cluster.cluster2.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.cluster2.kube_config.0.cluster_ca_certificate)
  }
}

provider "kubernetes" {
  alias                  = "cluster2"
  host                   = data.azurerm_kubernetes_cluster.cluster2.kube_config.0.host
  client_certificate     = base64decode(data.azurerm_kubernetes_cluster.cluster2.kube_config.0.client_certificate)
  client_key             = base64decode(data.azurerm_kubernetes_cluster.cluster2.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.cluster2.kube_config.0.cluster_ca_certificate)
}

provider "kubectl" {
  alias                  = "cluster2"
  host                   = data.azurerm_kubernetes_cluster.cluster2.kube_config.0.host
  client_certificate     = base64decode(data.azurerm_kubernetes_cluster.cluster2.kube_config.0.client_certificate)
  client_key             = base64decode(data.azurerm_kubernetes_cluster.cluster2.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.cluster2.kube_config.0.cluster_ca_certificate)
}

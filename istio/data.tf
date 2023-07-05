data "azurerm_kubernetes_cluster" "cluster1" {
  name                = var.cluster1.name
  resource_group_name = var.cluster1.resource_group_name
}

data "azurerm_kubernetes_cluster" "cluster2" {
  name                = var.cluster2.name
  resource_group_name = var.cluster2.resource_group_name
}

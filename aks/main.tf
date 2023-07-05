module "cluster1" {
  source = "../modules/aks-cluster"

  resource_group_location = "eastus"
}

module "cluster2" {
  source = "../modules/aks-cluster"

  resource_group_location = "westus2"
}

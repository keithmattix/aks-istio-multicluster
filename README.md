# Istio Multi-Cluster Demo on AKS

This repository contains the code and instructions to deploy a multi-cluster Istio mesh on Azure Kubernetes Service (AKS). The demo is based on the [Istio multi-primary](https://istio.io/docs/setup/install/multicluster/multi-primary_multi-network/) installation model.

## Requirements

- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
  - Log in before running `terraform apply`
- [Terraform](https://developer.hashicorp.com/terraform/downloads)
- [Kubectl](https://kubernetes.io/docs/reference/kubectl/) installed on the machine running Terraform
- [Istioctl](https://istio.io/latest/docs/setup/getting-started/#download) installed on the machine running Terraform

## Getting Started

1. (optionally) Create a *.tfvars(.json) file in the istio directory. There are only the required variables:
   1. If you don't `terraform apply` will prompt you for them

```json
{
  "mesh_id": "MESH_ID",
  "cluster1": {
    "name": "CLUSTER1_NAME",
    "resource_group_name": "CLUSTER1_RESOURCE_GROUP_NAME"
  },
  "cluster2": {
    "name": "CLUSTER1_NAME",
    "resource_group_name": "CLUSTER1_RESOURCE_GROUP_NAME"
  }
}
```

2. Run `terraform init` in the `aks` directory followed by `terraform apply`
3. Run `terraform init` in the `istio` directory followed by `terraform apply`

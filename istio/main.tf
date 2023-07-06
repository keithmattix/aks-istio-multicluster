module "root-cert" {
  source = "../modules/root-cert"

  root_ca_common_name  = "northwindtraders.com"
  root_ca_organization = "Northwind Traders"
}

module "cluster1-intermediate-cert" {
  source = "../modules/intermediate-cert"

  csr_subject = {
    common_name  = "cluster1.northwindtraders.com"
    country      = "US"
    locality     = "Seattle"
    province     = "Washington"
    org_unit     = "Infrastructure Engineering"
    organization = "Northwind Traders"
  }

  root_ca_cert_pem = module.root-cert.root_ca_cert_pem
  signing_key_pem  = module.root-cert.signing_key
}

module "cluster2-intermediate-cert" {
  source = "../modules/intermediate-cert"

  csr_subject = {
    common_name  = "cluster1.northwindtraders.com"
    country      = "US"
    locality     = "Seattle"
    province     = "Washington"
    org_unit     = "Infrastructure Engineering"
    organization = "Northwind Traders"
  }

  root_ca_cert_pem = module.root-cert.root_ca_cert_pem
  signing_key_pem  = module.root-cert.signing_key
}

module "cluster1-istio" {
  source = "../modules/istio-multicluster-member"

  istio_ca_cert_private_key = module.cluster1-intermediate-cert.private_key_pem
  istio_ca_cert             = module.cluster1-intermediate-cert.intermediate_ca_cert_pem
  istio_root_cert           = module.root-cert.root_ca_cert_pem
  istio_cert_chain          = <<PEM
${module.cluster1-intermediate-cert.intermediate_ca_cert_pem}
${module.root-cert.root_ca_cert_pem}
PEM
  is_primary                = true

  cluster_name = data.azurerm_kubernetes_cluster.cluster1.name
  mesh_id      = var.mesh_id
  network_id   = "east-network"

  providers = {
    kubernetes = kubernetes.cluster1
    kubectl    = kubectl.cluster1
    helm       = helm.cluster1
  }
}

module "cluster2-istio" {
  source = "../modules/istio-multicluster-member"

  istio_ca_cert_private_key = module.cluster2-intermediate-cert.private_key_pem
  istio_ca_cert             = module.cluster2-intermediate-cert.intermediate_ca_cert_pem
  istio_root_cert           = module.root-cert.root_ca_cert_pem
  istio_cert_chain          = "${module.cluster2-intermediate-cert.intermediate_ca_cert_pem}${module.root-cert.root_ca_cert_pem}" # Newlines are added automatically
  is_primary                = true

  cluster_name = data.azurerm_kubernetes_cluster.cluster2.name
  mesh_id      = var.mesh_id
  network_id   = "west-network"

  providers = {
    kubernetes = kubernetes.cluster2
    kubectl    = kubectl.cluster2
    helm       = helm.cluster2
  }
}

resource "terraform_data" "save-cluster1-kubeconfig" {
  provisioner "local-exec" {
    command = "echo '${data.azurerm_kubernetes_cluster.cluster1.kube_config_raw}' > cluster1.kubeconfig"
  }
}

resource "terraform_data" "save-cluster2-kubeconfig" {
  provisioner "local-exec" {
    command = "echo '${data.azurerm_kubernetes_cluster.cluster2.kube_config_raw}' > cluster2.kubeconfig"
  }
}

resource "terraform_data" "create-cluster1-remote-secret-in-cluster2" {
  provisioner "local-exec" {
    command = "istioctl x create-remote-secret --kubeconfig=./cluster1.kubeconfig --name=${data.azurerm_kubernetes_cluster.cluster1.name} | kubectl apply -f - --kubeconfig=./cluster2.kubeconfig"
  }

  depends_on = [module.cluster1-istio, module.cluster2-istio]
}

resource "terraform_data" "create-cluster2-remote-secret-in-cluster1" {
  provisioner "local-exec" {
    command = "istioctl x create-remote-secret --kubeconfig=./cluster2.kubeconfig --name=${data.azurerm_kubernetes_cluster.cluster2.name} | kubectl apply -f - --kubeconfig=./cluster1.kubeconfig"
  }

  depends_on = [module.cluster1-istio, module.cluster1-istio]
}

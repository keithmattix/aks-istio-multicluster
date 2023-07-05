resource "kubernetes_namespace" "istio-system" {
  metadata {
    name = "istio-system"
    labels = {
      "topology.istio.io/network" = var.network_id
    }
  }
}

resource "kubernetes_secret" "cacerts" {
  metadata {
    name      = "cacerts"
    namespace = kubernetes_namespace.istio-system.metadata[0].name
  }

  data = {
    "ca-cert.pem"    = var.istio_ca_cert
    "ca-key.pem"     = var.istio_ca_cert_private_key
    "root-cert.pem"  = var.istio_root_cert
    "cert-chain.pem" = var.istio_cert_chain
  }
}

resource "helm_release" "istio-base" {
  name = "istio-base"

  repository = "https://istio-release.storage.googleapis.com/charts"
  chart      = "base"
  version    = "1.18.0"

  namespace = kubernetes_namespace.istio-system.metadata[0].name
}

resource "helm_release" "istiod" {
  name = "istiod"

  repository = "https://istio-release.storage.googleapis.com/charts"
  chart      = "istiod"
  version    = "1.18.0"
  namespace  = kubernetes_namespace.istio-system.metadata[0].name

  depends_on = [helm_release.istio-base]

  set {
    name  = "global.meshID"
    value = var.mesh_id
    type  = "string"
  }

  set {
    name  = "global.network"
    value = var.network_id
    type  = "string"
  }

  set {
    name  = "global.multiCluster.clusterName"
    value = var.cluster_name
    type  = "string"
  }

  set {
    name  = "global.multiCluster.enabled"
    value = true
  }
}

resource "helm_release" "istio-eastwest-gateway" {
  name      = "istio-eastwest-gateway"
  namespace = kubernetes_namespace.istio-system.metadata[0].name

  repository = "https://istio-release.storage.googleapis.com/charts"
  chart      = "gateway"
  version    = "1.18.0"
  depends_on = [helm_release.istiod]

  set {
    name  = "networkGateway"
    value = var.network_id
    type  = "string"
  }
}

resource "kubectl_manifest" "istio-eastwest-gateway-service" {
  yaml_body = <<YAML
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: cross-network-gateway
  namespace: istio-system
spec:
  selector:
    istio: eastwest-gateway
  servers:
    - port:
        number: 15443
        name: tls
        protocol: TLS
      tls:
        mode: AUTO_PASSTHROUGH
      hosts:
        - "*.local"
YAML

  depends_on = [helm_release.istio-eastwest-gateway]
}

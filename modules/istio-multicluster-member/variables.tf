variable "cluster_name" {
  description = "The name of the cluster within the mesh"
  type        = string

  nullable = false
}

variable "is_primary" {
  description = "Whether or not this cluster should have an istiod installed in it"
  type        = bool

  validation {
    condition     = var.is_primary == true
    error_message = "This module currently only supports primary clusters."
  }
}

variable "istio_ca_cert" {
  description = "The certificate used to sign workload certificates in the mesh"
  type        = string

  sensitive = true
  nullable  = false
}

variable "istio_ca_cert_private_key" {
  description = "The private key used for the ca cert"
  type        = string

  sensitive = true
  nullable  = false
}


variable "istio_cert_chain" {
  description = "The full cert chain that should be used to validate incoming mTLS connections (should include istio_root_cert)"
  type        = string

  sensitive = true
}

variable "istio_root_cert" {
  description = "The root certificate used to sign istio_ca_cert"
  type        = string

  sensitive = true
}

variable "mesh_id" {
  description = "The Istio mesh ID"
  type        = string

  nullable = false
}

variable "network_id" {
  description = "The Istio network ID"
  type = string

  nullable = false
}

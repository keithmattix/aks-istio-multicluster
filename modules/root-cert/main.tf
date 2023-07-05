resource "tls_private_key" "root" {
  algorithm   = var.key_algorithm
  rsa_bits    = var.key_algorithm == "" ? var.rsa_bits : null
  ecdsa_curve = var.key_algorithm == "ECDSA" ? var.ecdsa_curve : null
}

resource "tls_self_signed_cert" "root-ca" {
  private_key_pem = tls_private_key.root.private_key_pem
  subject {
    common_name  = var.root_ca_common_name
    organization = var.root_ca_organization
  }

  is_ca_certificate = true

  allowed_uses = [
    "cert_signing",
    "crl_signing",
    "digital_signature",
  ]

  validity_period_hours = var.validity_period_hours
}

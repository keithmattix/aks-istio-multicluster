resource "tls_private_key" "intermediate-key" {
  algorithm   = var.key_algorithm
  rsa_bits    = var.key_algorithm == "RSA" ? var.rsa_bits : null
  ecdsa_curve = var.key_algorithm == "ECDSA" ? var.ecdsa_curve : null
}

resource "tls_cert_request" "intermediate-csr" {
  private_key_pem = tls_private_key.intermediate-key.private_key_pem

  subject {
    country             = var.csr_subject.country
    province            = var.csr_subject.province
    locality            = var.csr_subject.locality
    common_name         = var.csr_subject.common_name
    organization        = var.csr_subject.organization
    organizational_unit = var.csr_subject.org_unit 
  }
}

resource "tls_locally_signed_cert" "intermediate-ca" {
  cert_request_pem      = tls_cert_request.intermediate-csr.cert_request_pem
  ca_private_key_pem    = var.signing_key_pem
  ca_cert_pem           = var.root_ca_cert_pem
  validity_period_hours = var.validity_period_hours

  is_ca_certificate = true

  allowed_uses = [
    "cert_signing",
    "crl_signing",
    "digital_signature",
  ]
}

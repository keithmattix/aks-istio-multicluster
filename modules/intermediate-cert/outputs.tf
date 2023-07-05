output "private_key_pem" {
  value = tls_private_key.intermediate-key.private_key_pem

  sensitive = true
}

output "intermediate_ca_cert_pem" {
  value = tls_locally_signed_cert.intermediate-ca.cert_pem

  sensitive = true
}

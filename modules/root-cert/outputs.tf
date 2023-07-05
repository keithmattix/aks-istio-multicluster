output "root_ca_cert_pem" {
  value = tls_self_signed_cert.root-ca.cert_pem

  sensitive = true
}

output "signing_key" {
  value = tls_private_key.root.private_key_pem

  sensitive = true
}

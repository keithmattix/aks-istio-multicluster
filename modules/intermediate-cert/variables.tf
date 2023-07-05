variable "root_ca_cert_pem" {
  description = "The PEM-encoded root certificate (public key)"
  type        = string

  sensitive = true
  nullable  = false
}

variable "signing_key_pem" {
  description = "The PEM-encoded private key used to sign the intermediate certificate."
  type        = string

  sensitive = true
  nullable  = false
}

variable "key_algorithm" {
  description = "The algorithm to use for the key"
  default     = "RSA"
  type        = string
}


variable "rsa_bits" {
  description = "The number of bits to use for the key (RSA only)"
  default     = 4096
  type        = number
}

variable "ecdsa_curve" {
  description = "The curve to use for the key (ECDSA only)"
  default     = "P224"
  type        = string
}

variable "csr_subject" {
  description = "The subject to use for the CSR."
  type = object({
    country      = string
    province     = string
    locality     = string
    org_unit     = string
    common_name  = string
    organization = string
  })

  nullable = false
}

variable "validity_period_hours" {
  description = "The number of hours the certificate is valid for (defaults to 5 years)"
  default     = 43800 # 5 years
  type        = number
}

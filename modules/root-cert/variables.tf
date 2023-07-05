variable "key_algorithm" {
  description = "The algorithm to use for the key"
  default     = "RSA"
  type        = string
}


variable "rsa_bits" {
  description = "The number of bits to use for the key (RSA only)"
  default     = 4096
  type       = number
}

variable "ecdsa_curve" {
  description = "The curve to use for the key (ECDSA only)"
  default     = "P224"
  type        = string
}

variable "root_ca_common_name" {
  description = "The common name to use for the root CA"
  type        = string

  nullable = false
}

variable "root_ca_organization" {
  description = "The organization to use for the root CA"
  type        = string

  nullable = false
}

variable "validity_period_hours" {
  description = "The number of hours the certificate is valid for (defaults to 10 years)"
  default     = 87600 # 10 years
  type        = number
}

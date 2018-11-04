resource "tls_private_key" "ca_intermediate" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "tls_cert_request" "ca_intermediate" {
  key_algorithm   = "${ tls_private_key.ca_intermediate.algorithm }"
  private_key_pem = "${ tls_private_key.ca_intermediate.private_key_pem }"

  subject {
    common_name  = "Sean Lingren Intermediate CA"
    organization = "Sean Lingren"
    country      = "US"
  }
}

resource "tls_locally_signed_cert" "ca_intermediate" {
  cert_request_pem = "${ tls_cert_request.ca_intermediate.cert_request_pem }"

  ca_key_algorithm   = "${ tls_private_key.ca_root.algorithm }"
  ca_cert_pem        = "${ tls_self_signed_cert.ca_root.cert_pem }"
  ca_private_key_pem = "${ tls_private_key.ca_root.private_key_pem }"

  is_ca_certificate     = true
  validity_period_hours = 876000 # 100 years

  allowed_uses = [
    "cert_signing",
    "crl_signing",
  ]
}

locals {
  ca_intermediate_cert = "${ tls_locally_signed_cert.ca_intermediate.cert_pem }"
}

output "ca_intermediate_cert" {
  value = "${ local.ca_intermediate_cert }"
}

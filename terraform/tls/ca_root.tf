resource "tls_private_key" "ca_root" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "tls_self_signed_cert" "ca_root" {
  is_ca_certificate = true

  key_algorithm         = "${ tls_private_key.ca_root.algorithm }"
  private_key_pem       = "${ tls_private_key.ca_root.private_key_pem }"
  validity_period_hours = 1752000                                        # 200 years

  subject {
    common_name  = "Sean Lingren Root CA"
    organization = "Sean Lingren"
    country      = "US"
  }

  allowed_uses = [
    "cert_signing",
    "crl_signing",
  ]
}

locals {
  ca_root_cert = "${ tls_self_signed_cert.ca_root.cert_pem }"
}

output "ca_root_cert" {
  value = "${ local.ca_root_cert }"
}

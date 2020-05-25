resource "tls_private_key" "ca" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "tls_self_signed_cert" "ca" {
  is_ca_certificate = true

  key_algorithm         = tls_private_key.ca.algorithm
  private_key_pem       = tls_private_key.ca.private_key_pem
  validity_period_hours = 1752000 # 200 years

  subject {
    common_name  = "vault"
    organization = "vault"
  }

  allowed_uses = [
    "cert_signing",
    "crl_signing",
  ]
}

resource "tls_private_key" "cert" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "tls_cert_request" "cert" {
  key_algorithm   = tls_private_key.cert.algorithm
  private_key_pem = tls_private_key.cert.private_key_pem

  dns_names = [var.domain_name]

  subject {
    common_name  = var.domain_name
    organization = "vault"
  }
}

resource "tls_locally_signed_cert" "cert" {
  cert_request_pem = tls_cert_request.cert.cert_request_pem

  ca_key_algorithm   = tls_private_key.ca.algorithm
  ca_private_key_pem = tls_private_key.ca.private_key_pem
  ca_cert_pem        = tls_self_signed_cert.ca.cert_pem

  is_ca_certificate     = false
  validity_period_hours = 876000 # 100 years

  allowed_uses = [
    "digital_signature",
    "key_encipherment",
    "server_auth",
  ]
}

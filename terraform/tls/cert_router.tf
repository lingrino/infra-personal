resource "tls_private_key" "cert_router" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "tls_cert_request" "cert_router" {
  key_algorithm   = tls_private_key.cert_router.algorithm
  private_key_pem = tls_private_key.cert_router.private_key_pem

  dns_names = [
    "router.sean",
  ]

  ip_addresses = [
    "192.168.1.1",
  ]

  subject {
    common_name  = "router.sean"
    organization = "Sean Lingren"
    country      = "US"
  }
}

resource "tls_locally_signed_cert" "cert_router" {
  cert_request_pem = tls_cert_request.cert_router.cert_request_pem

  ca_key_algorithm   = tls_private_key.ca_intermediate.algorithm
  ca_private_key_pem = tls_private_key.ca_intermediate.private_key_pem
  ca_cert_pem        = tls_locally_signed_cert.ca_intermediate.cert_pem

  is_ca_certificate     = false
  validity_period_hours = 876000 # 50 years

  allowed_uses = [
    "digital_signature",
    "key_encipherment",
    "server_auth",
  ]
}

output "cert_router_cert" {
  value = tls_locally_signed_cert.cert_router.cert_pem
}

output "cert_router_chain" {
  value = "${local.ca_intermediate_cert}${local.ca_root_cert}"
}

output "cert_router_priv" {
  value = tls_private_key.cert_router.private_key_pem
}

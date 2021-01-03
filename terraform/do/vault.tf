locals {
  vault_version       = "1.6.0" # https://www.vaultproject.io/downloads
  vault_agent_version = "0.6.0" # https://hub.docker.com/r/hashicorp/vault-k8s/tags
  vault_domain_name   = "vault.lingrino.dev"
}

resource "kubernetes_namespace" "vault" {
  metadata {
    generate_name = "vault-"
  }
}

resource "kubernetes_secret" "vault" {
  metadata {
    generate_name = "vault-"
    namespace     = kubernetes_namespace.vault.id
  }

  data = {
    AWS_REGION            = data.terraform_remote_state.account_prod.outputs.vault_region
    AWS_ACCESS_KEY_ID     = data.terraform_remote_state.account_prod.outputs.vault_user_akid
    AWS_SECRET_ACCESS_KEY = data.terraform_remote_state.account_prod.outputs.vault_user_sak
  }
}

resource "kubernetes_secret" "vault_certs" {
  metadata {
    generate_name = "vault-certs-"
    namespace     = kubernetes_namespace.vault.id
  }

  data = {
    "crt.pem" = tls_locally_signed_cert.vault_cert.cert_pem
    "key.pem" = tls_private_key.vault_cert.private_key_pem
  }
}

resource "helm_release" "vault" {
  repository = "https://helm.releases.hashicorp.com"
  chart      = "vault"

  name        = "vault"
  description = "vault"
  namespace   = kubernetes_namespace.vault.id

  cleanup_on_fail   = true
  dependency_update = true

  values = [templatefile("files/vault-values.yaml", {
    version           = local.vault_version
    agent_version     = local.vault_agent_version
    domain_name       = local.vault_domain_name
    aws_region        = data.terraform_remote_state.account_prod.outputs.vault_region
    dynamo_name       = data.terraform_remote_state.account_prod.outputs.vault_dynamo_name
    kms_key_id        = data.terraform_remote_state.account_prod.outputs.vault_kms_id
    secret_certs_name = kubernetes_secret.vault_certs.metadata.0.name
  })]
}


############################

resource "tls_private_key" "vault_ca" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "tls_self_signed_cert" "vault_ca" {
  is_ca_certificate = true

  key_algorithm         = tls_private_key.vault_ca.algorithm
  private_key_pem       = tls_private_key.vault_ca.private_key_pem
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

resource "tls_private_key" "vault_cert" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "tls_cert_request" "vault_cert" {
  key_algorithm   = tls_private_key.vault_cert.algorithm
  private_key_pem = tls_private_key.vault_cert.private_key_pem

  dns_names = [local.vault_domain_name]

  subject {
    common_name  = local.vault_domain_name
    organization = "vault"
  }
}

resource "tls_locally_signed_cert" "vault_cert" {
  cert_request_pem = tls_cert_request.vault_cert.cert_request_pem

  ca_key_algorithm   = tls_private_key.vault_ca.algorithm
  ca_private_key_pem = tls_private_key.vault_ca.private_key_pem
  ca_cert_pem        = tls_self_signed_cert.vault_ca.cert_pem

  is_ca_certificate     = false
  validity_period_hours = 876000 # 100 years

  allowed_uses = [
    "digital_signature",
    "key_encipherment",
    "server_auth",
  ]
}

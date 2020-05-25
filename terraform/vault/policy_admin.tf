# https://learn.hashicorp.com/vault/identity-access-management/iam-policies#example-policy-for-admin

resource "vault_policy" "admin" {
  name   = "admin"
  policy = data.vault_policy_document.admin.hcl
}

data "vault_policy_document" "admin" {
  rule {
    path         = "auth/*"
    capabilities = ["create", "read", "update", "delete", "list", "sudo"]
    description  = "Manage auth methods broadly across Vault"
  }
  rule {
    path         = "sys/*"
    capabilities = ["create", "read", "update", "delete", "list", "sudo"]
    description  = "Manage all sys methods"
  }
  rule {
    path         = "kv/*"
    capabilities = ["create", "read", "update", "delete", "list", "sudo"]
    description  = "Manage all secrets"
  }
}

resource "vault_github_auth_backend" "lingrino_org" {
  organization = "lingrino-org"
  description  = "github auth backend for lingrino-org"
}

resource "vault_github_team" "admin" {
  backend  = vault_github_auth_backend.lingrino_org.id
  team     = "vault-admin"
  policies = ["admin"]
}

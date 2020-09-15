resource "github_team" "vault_admin" {
  name        = "vault-admin"
  description = "Vault Admins"
  privacy     = "secret"
}

resource "github_team_membership" "vault_admin_lingrino" {
  team_id  = github_team.vault_admin.id
  username = github_membership.lingrino.username
  role     = "maintainer"
}

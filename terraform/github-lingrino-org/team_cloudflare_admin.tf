resource "github_team" "cloudflare_access_admin" {
  name        = "cloudflare-access-admin"
  description = "Cloudflare Access Admins"
  privacy     = "secret"
}

resource "github_team_membership" "cloudflare_access_admin_lingrino" {
  team_id  = github_team.cloudflare_access_admin.id
  username = github_membership.lingrino.username
  role     = "maintainer"
}

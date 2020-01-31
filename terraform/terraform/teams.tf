resource "tfe_team" "owners" {
  organization = tfe_organization.org.id
  name         = "owners"
}

resource "tfe_team_members" "owners" {
  team_id = tfe_team.owners.id

  usernames = [
    "lingrino",
    "api-org-lingrino",
    "gh-webhooks-lingrino",
  ]
}

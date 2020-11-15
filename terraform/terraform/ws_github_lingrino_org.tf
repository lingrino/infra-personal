resource "tfe_workspace" "github_lingrino_org" {
  organization = tfe_organization.org.id
  name         = "github-lingrino-org"

  terraform_version = "latest"
  working_directory = "terraform/github-lingrino-org"

  operations            = false
  auto_apply            = true
  queue_all_runs        = false
  file_triggers_enabled = true

  vcs_repo {
    identifier     = "lingrino/infra-personal"
    branch         = "main"
    oauth_token_id = var.oauth_token_id
  }
}

resource "tfe_notification_configuration" "github_lingrino_org" {
  name         = "github_lingrino_org"
  enabled      = true
  workspace_id = tfe_workspace.github_lingrino_org.id

  destination_type = "email"
  email_user_ids   = [tfe_organization_membership.lingrino.user_id]

  triggers = [
    "run:errored",
    "run:needs_attention",
  ]
}

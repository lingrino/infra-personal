resource "tfe_workspace" "do" {
  organization = tfe_organization.org.id
  name         = "do"

  terraform_version = "latest"
  working_directory = "terraform/do"

  execution_mode        = "remote"
  auto_apply            = true
  queue_all_runs        = false
  allow_destroy_plan    = false
  file_triggers_enabled = true

  vcs_repo {
    identifier     = "lingrino/infra-personal"
    branch         = "main"
    oauth_token_id = var.oauth_token_id
  }
}

resource "tfe_notification_configuration" "do" {
  name         = "do"
  enabled      = true
  workspace_id = tfe_workspace.do.id

  destination_type = "email"
  email_user_ids   = [tfe_organization_membership.lingrino.user_id]

  triggers = [
    "run:errored",
    "run:needs_attention",
  ]
}

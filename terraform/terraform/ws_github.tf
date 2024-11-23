resource "tfe_workspace" "github" {
  organization = tfe_organization.org.id
  name         = "github"

  terraform_version = "latest"
  working_directory = "terraform/github"

  auto_apply            = true
  queue_all_runs        = false
  allow_destroy_plan    = false
  file_triggers_enabled = true
  global_remote_state   = true

  vcs_repo {
    identifier     = "lingrino/infra-personal"
    branch         = "main"
    oauth_token_id = data.tfe_oauth_client.github.oauth_token_id
  }

  trigger_patterns = [
    "terraform/github",
    "terraform-modules/**/*",
  ]
}

resource "tfe_workspace_variable_set" "github" {
  workspace_id    = tfe_workspace.github.id
  variable_set_id = tfe_variable_set.all.id
}

resource "tfe_notification_configuration" "github" {
  name         = "github"
  enabled      = true
  workspace_id = tfe_workspace.github.id

  destination_type = "email"
  email_user_ids   = [tfe_organization_membership.lingrino.user_id]

  triggers = [
    "run:errored",
    "run:needs_attention",
  ]
}

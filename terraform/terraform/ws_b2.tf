resource "tfe_workspace" "b2" {
  organization = tfe_organization.org.id
  name         = "b2"

  terraform_version = "latest"
  working_directory = "terraform/b2"

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
    "terraform/b2",
    "terraform-modules/**/*",
  ]
}

resource "tfe_workspace_variable_set" "b2" {
  workspace_id    = tfe_workspace.b2.id
  variable_set_id = tfe_variable_set.all.id
}

resource "tfe_notification_configuration" "b2" {
  name         = "b2"
  enabled      = true
  workspace_id = tfe_workspace.b2.id

  destination_type = "email"
  email_user_ids   = [tfe_organization_membership.lingrino.user_id]

  triggers = [
    "run:errored",
    "run:needs_attention",
  ]
}

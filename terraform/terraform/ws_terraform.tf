resource "tfe_workspace" "terraform" {
  organization = tfe_organization.org.id
  name         = "terraform"

  terraform_version = "latest"
  working_directory = "terraform/terraform"

  execution_mode        = "local"
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

resource "tfe_notification_configuration" "terraform" {
  name         = "terraform"
  enabled      = true
  workspace_id = tfe_workspace.terraform.id

  destination_type = "email"
  email_user_ids   = [tfe_organization_membership.lingrino.user_id]

  triggers = [
    "run:errored",
    "run:needs_attention",
  ]
}

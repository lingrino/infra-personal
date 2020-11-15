resource "tfe_workspace" "aws_accounts_root" {
  organization = tfe_organization.org.id
  name         = "aws-accounts-root"

  terraform_version = "latest"
  working_directory = "terraform/aws/accounts/root"

  operations            = false
  auto_apply            = true
  queue_all_runs        = false
  file_triggers_enabled = true

  vcs_repo {
    identifier     = "lingrino/infra-personal"
    branch         = "main"
    oauth_token_id = var.oauth_token_id
  }

  trigger_prefixes = [
    "terraform-modules"
  ]
}

resource "tfe_notification_configuration" "aws_accounts_root" {
  name         = "aws_accounts_root"
  enabled      = true
  workspace_id = tfe_workspace.aws_accounts_root.id

  destination_type = "email"
  email_user_ids   = [tfe_organization_membership.lingrino.user_id]

  triggers = [
    "run:errored",
    "run:needs_attention",
  ]
}

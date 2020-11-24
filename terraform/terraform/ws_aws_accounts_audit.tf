resource "tfe_workspace" "aws_accounts_audit" {
  organization = tfe_organization.org.id
  name         = "aws-accounts-audit"

  terraform_version = "latest"
  working_directory = "terraform/aws/accounts/audit"

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

  trigger_prefixes = [
    "terraform-modules"
  ]
}

resource "tfe_notification_configuration" "aws_accounts_audit" {
  name         = "aws_accounts_audit"
  enabled      = true
  workspace_id = tfe_workspace.aws_accounts_audit.id

  destination_type = "email"
  email_user_ids   = [tfe_organization_membership.lingrino.user_id]

  triggers = [
    "run:errored",
    "run:needs_attention",
  ]
}

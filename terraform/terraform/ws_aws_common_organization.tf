resource "tfe_workspace" "aws_common_organization" {
  organization = tfe_organization.org.id
  name         = "aws-common-organization"

  terraform_version = "latest"
  working_directory = "terraform/aws/common/organization"

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

  trigger_prefixes = [
    "terraform-modules"
  ]
}

resource "tfe_notification_configuration" "aws_common_organization" {
  name         = "aws_common_organization"
  enabled      = true
  workspace_id = tfe_workspace.aws_common_organization.id

  destination_type = "email"
  email_user_ids   = [tfe_organization_membership.lingrino.user_id]

  triggers = [
    "run:errored",
    "run:needs_attention",
  ]
}

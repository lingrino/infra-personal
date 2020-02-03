resource "tfe_workspace" "aws_accounts_auth" {
  organization = tfe_organization.org.id
  name         = "aws-accounts-auth"

  terraform_version = "latest"
  working_directory = "terraform/aws/accounts/auth"

  operations            = true
  auto_apply            = true
  queue_all_runs        = false
  file_triggers_enabled = true

  vcs_repo {
    identifier     = "lingrino/infra-personal"
    oauth_token_id = var.oauth_token_id
  }

  trigger_prefixes = [
    "terraform-modules"
  ]
}

# TODO - This variable should be read from a secret place and added here
# resource "tfe_variable" "auth_tfe_token" {
#   workspace_id = tfe_workspace.auth.id
#   category     = "env"

#   key       = "TFE_TOKEN"
#   value     = "TODO"
#   sensitive = true
# }

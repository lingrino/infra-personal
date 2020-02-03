resource "tfe_workspace" "terraform" {
  organization = tfe_organization.org.id
  name         = "terraform"

  terraform_version = "latest"
  working_directory = "terraform/terraform"

  operations            = true
  auto_apply            = true
  queue_all_runs        = false
  file_triggers_enabled = true

  vcs_repo {
    identifier     = "lingrino/infra-personal"
    oauth_token_id = var.oauth_token_id
  }
}

# TODO - This variable should be read from a secret place and added here
# resource "tfe_variable" "terraform_tfe_token" {
#   workspace_id = tfe_workspace.terraform.id
#   category     = "env"

#   key       = "TFE_TOKEN"
#   value     = "TODO"
#   sensitive = true
# }

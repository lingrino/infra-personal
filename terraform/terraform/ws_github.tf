resource "tfe_workspace" "github" {
  organization = tfe_organization.org.id
  name         = "github"

  terraform_version = "latest"
  working_directory = "terraform/github"

  operations            = false
  auto_apply            = false
  queue_all_runs        = false
  file_triggers_enabled = true

  vcs_repo {
    identifier     = "lingrino/infra-personal"
    oauth_token_id = var.oauth_token_id
  }
}

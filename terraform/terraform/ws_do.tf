resource "tfe_workspace" "do" {
  organization = tfe_organization.org.id
  name         = "do"

  terraform_version = "latest"
  working_directory = "terraform/do"

  operations            = true
  auto_apply            = true
  queue_all_runs        = false
  file_triggers_enabled = true

  vcs_repo {
    identifier     = "lingrino/infra-personal"
    branch         = "main"
    oauth_token_id = var.oauth_token_id
  }
}

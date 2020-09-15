resource "tfe_workspace" "github_lingrino_org" {
  organization = tfe_organization.org.id
  name         = "github-lingrino-org"

  terraform_version = "latest"
  working_directory = "terraform/github-lingrino-org"

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

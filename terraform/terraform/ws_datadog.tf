resource "tfe_workspace" "datadog" {
  organization = tfe_organization.org.id
  name         = "datadog"

  terraform_version = "latest"
  working_directory = "terraform/datadog"

  operations            = true
  auto_apply            = true
  queue_all_runs        = false
  file_triggers_enabled = true

  vcs_repo {
    identifier     = "lingrino/infra-personal"
    oauth_token_id = var.oauth_token_id
  }
}

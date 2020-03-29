resource "tfe_workspace" "github" {
  organization = tfe_organization.org.id
  name         = "github"

  terraform_version = "latest"
  working_directory = "terraform/github"

  operations            = true
  auto_apply            = true
  queue_all_runs        = false
  file_triggers_enabled = true

  vcs_repo {
    identifier     = "lingrino/infra-personal"
    oauth_token_id = var.oauth_token_id
  }
}

resource "tfe_variable" "github_github_organization" {
  workspace_id = tfe_workspace.github.id
  category     = "env"

  description = "github organization for the github provider"
  key         = "GITHUB_ORGANIZATION"
  value       = "lingrino"
}

# his variable should be read from a secret place and added here
# resource "tfe_variable" "github_github_token" {
#   workspace_id = tfe_workspace.github.id
#   category     = "env"

#   description = "token used with the github provider"
#   key         = "GITHUB_TOKEN"
#   value       = ""
#   sensitive   = true
# }

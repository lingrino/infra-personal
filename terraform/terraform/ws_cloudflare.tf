resource "tfe_workspace" "cloudflare" {
  organization = tfe_organization.org.id
  name         = "cloudflare"

  terraform_version = "latest"
  working_directory = "terraform/cloudflare"

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

resource "tfe_workspace" "aws_common_dns" {
  organization = tfe_organization.org.id
  name         = "aws-common-dns"

  terraform_version = "latest"
  working_directory = "terraform/aws/common/dns"

  operations            = true
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

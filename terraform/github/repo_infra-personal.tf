resource "github_repository" "infra-personal" {
  name         = "infra-personal"
  description  = "Terraform for setting up my personal infrastructure"
  homepage_url = "https://lingrino.com"

  default_branch = "main"
  visibility     = "public"

  has_wiki     = false
  has_issues   = true
  has_projects = false

  allow_merge_commit     = true
  allow_squash_merge     = true
  allow_rebase_merge     = true
  delete_branch_on_merge = true

  topics = [
    "automation",
    "aws",
    "cloud",
    "infrastructure",
    "terraform",
  ]
}

module "infra-personal-labels" {
  source = "../../terraform-modules/github-repo-labels//"
  repo   = github_repository.infra-personal.name
}

resource "github_actions_secret" "infra_personal_aws_access_key_id_user" {
  repository      = github_repository.infra-personal.name
  secret_name     = "AWS_ACCESS_KEY_ID_USER"
  plaintext_value = data.terraform_remote_state.account_auth.outputs.iam_user_github_actions_akid
}

resource "github_actions_secret" "infra_personal_aws_secret_access_key_user" {
  repository      = github_repository.infra-personal.name
  secret_name     = "AWS_SECRET_ACCESS_KEY_USER"
  plaintext_value = data.terraform_remote_state.account_auth.outputs.iam_user_github_actions_sak
}

# resource "github_branch_protection" "infra-personal" {
#   repository     = github_repository.infra-personal.name
#   branch         = "main"
#   enforce_admins = true

#   required_status_checks {
#     strict = true
#     contexts = [
#       "atlas/lingrino/aws-accounts-audit",
#       "atlas/lingrino/aws-accounts-auth",
#       "atlas/lingrino/aws-accounts-dev",
#       "atlas/lingrino/aws-accounts-prod",
#       "atlas/lingrino/aws-accounts-root",
#       "atlas/lingrino/aws-common-dns",
#       "atlas/lingrino/aws-common-organization",
#       "atlas/lingrino/github",
#       "atlas/lingrino/tls",
#       "validate"
#     ]
#   }
# }

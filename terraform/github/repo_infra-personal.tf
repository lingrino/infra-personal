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

resource "github_branch_protection" "infra-personal" {
  repository_id  = github_repository.infra-personal.node_id
  pattern        = "main"
  enforce_admins = true

  required_status_checks {
    strict = true
    contexts = [
      "Terraform Cloud/lingrino/aws-accounts-audit",
      "Terraform Cloud/lingrino/aws-accounts-auth",
      "Terraform Cloud/lingrino/aws-accounts-dev",
      "Terraform Cloud/lingrino/aws-accounts-prod",
      "Terraform Cloud/lingrino/aws-accounts-root",
      "Terraform Cloud/lingrino/aws-common-dns",
      "Terraform Cloud/lingrino/aws-common-organization",
      "Terraform Cloud/lingrino/github",
      "Terraform Cloud/lingrino/github-lingrino-org",
      "Terraform Cloud/lingrino/terraform",
      "Terraform Cloud/lingrino/tls",
      "validate"
    ]
  }
}

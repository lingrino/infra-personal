resource "github_repository" "vaku" {
  name         = "vaku"
  description  = "A CLI and Go API to extend the official Vault client"
  homepage_url = "https://vaku.dev/"

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
    "cli",
    "go",
    "golang",
    "vault",
    "vault-api",
    "vault-client",
  ]
}

module "vaku-labels" {
  source = "../../terraform-modules/github-repo-labels//"
  repo   = github_repository.vaku.name
}

resource "github_actions_secret" "vaku_aws_access_key_id" {
  repository      = github_repository.vaku.name
  secret_name     = "AWS_ACCESS_KEY_ID"
  plaintext_value = data.terraform_remote_state.account_prod.outputs.site_vaku_deployer_access_key_id
}

resource "github_actions_secret" "vaku_aws_secret_access_key_id" {
  repository      = github_repository.vaku.name
  secret_name     = "AWS_SECRET_ACCESS_KEY"
  plaintext_value = data.terraform_remote_state.account_prod.outputs.site_vaku_deployer_secret_access_key
}

resource "github_actions_secret" "vaku_cf_distribution_id" {
  repository      = github_repository.vaku.name
  secret_name     = "CF_DISTRIBUTION_ID"
  plaintext_value = data.terraform_remote_state.account_prod.outputs.site_vaku_distribution_id
}

resource "github_actions_secret" "vaku_s3_bucket_name" {
  repository      = github_repository.vaku.name
  secret_name     = "S3_BUCKET_NAME"
  plaintext_value = data.terraform_remote_state.account_prod.outputs.site_vaku_bucket_name
}

resource "github_actions_secret" "vaku_s3_region" {
  repository      = github_repository.vaku.name
  secret_name     = "S3_REGION"
  plaintext_value = "us-east-1"
}

# resource "github_branch_protection" "vaku" {
#   repository     = github_repository.vaku.name
#   branch         = "main"
#   enforce_admins = true

#   required_status_checks {
#     strict = true
#     contexts = [
#       "validate"
#     ]
#   }
# }

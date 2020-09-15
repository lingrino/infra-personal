resource "github_repository" "site-personal" {
  name         = "site-personal"
  description  = "My personal website"
  homepage_url = "https://lingrino.com"

  default_branch = "main"
  visibility     = "public"

  has_wiki     = false
  has_issues   = false
  has_projects = false

  allow_merge_commit     = true
  allow_squash_merge     = true
  allow_rebase_merge     = true
  delete_branch_on_merge = true

  topics = [
    "html",
    "website",
  ]
}

module "site-personal-labels" {
  source = "../../terraform-modules/github-repo-labels//"
  repo   = github_repository.site-personal.name
}

resource "github_actions_secret" "site_personal_aws_access_key_id" {
  repository      = github_repository.site-personal.name
  secret_name     = "AWS_ACCESS_KEY_ID"
  plaintext_value = data.terraform_remote_state.account_prod.outputs.site_personal_deployer_access_key_id
}

resource "github_actions_secret" "site_personal_aws_secret_access_key_id" {
  repository      = github_repository.site-personal.name
  secret_name     = "AWS_SECRET_ACCESS_KEY"
  plaintext_value = data.terraform_remote_state.account_prod.outputs.site_personal_deployer_secret_access_key
}

resource "github_actions_secret" "site_personal_cf_distribution_id" {
  repository      = github_repository.site-personal.name
  secret_name     = "CF_DISTRIBUTION_ID"
  plaintext_value = data.terraform_remote_state.account_prod.outputs.site_personal_distribution_id
}

resource "github_actions_secret" "site_personal_s3_bucket_name" {
  repository      = github_repository.site-personal.name
  secret_name     = "S3_BUCKET_NAME"
  plaintext_value = data.terraform_remote_state.account_prod.outputs.site_personal_bucket_name
}

resource "github_actions_secret" "site_personal_s3_region" {
  repository      = github_repository.site-personal.name
  secret_name     = "S3_REGION"
  plaintext_value = "us-east-1"
}

resource "github_repository" "repo" {
  name        = "infra-personal"
  description = "Terraform for setting up my personal infrastructure"

  default_branch = "master"
  private        = false

  has_wiki   = false
  has_issues = true

  allow_merge_commit = true
  allow_squash_merge = true
  allow_rebase_merge = true
}

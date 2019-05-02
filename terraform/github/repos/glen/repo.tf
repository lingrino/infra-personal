resource "github_repository" "repo" {
  name        = "glen"
  description = "A CLI to gather GitLab project and group variables"

  default_branch = "master"
  private        = false

  has_wiki   = false
  has_issues = true

  allow_merge_commit = true
  allow_squash_merge = true
  allow_rebase_merge = true
}

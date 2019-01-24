resource "github_repository" "repo" {
  name        = "snippets"
  description = "Useful code snippets not ready for OSS"

  default_branch = "master"
  private        = true

  has_wiki   = false
  has_issues = true

  allow_merge_commit = true
  allow_squash_merge = true
  allow_rebase_merge = true
}

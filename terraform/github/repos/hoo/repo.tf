resource "github_repository" "repo" {
  name        = "hoo"
  description = ""

  default_branch = "master"
  private        = true

  has_wiki   = false
  has_issues = true

  allow_merge_commit = true
  allow_squash_merge = true
  allow_rebase_merge = true
}

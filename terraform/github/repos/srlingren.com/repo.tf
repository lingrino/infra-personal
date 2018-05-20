resource "github_repository" "repo" {
  name         = "srlingren.com"
  description  = "My personal website"
  homepage_url = "https://srlingren.com"

  default_branch = "master"
  private        = false

  has_wiki   = false
  has_issues = false

  allow_merge_commit = true
  allow_squash_merge = true
  allow_rebase_merge = true
}

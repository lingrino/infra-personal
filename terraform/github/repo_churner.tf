resource "github_repository" "churner" {
  name         = "churner"
  description  = "A Credit Card Manager"
  homepage_url = "https://churner.io/"
  archived     = true

  default_branch = "master"
  private        = false

  has_wiki   = false
  has_issues = false

  allow_merge_commit = true
  allow_squash_merge = true
  allow_rebase_merge = true
}

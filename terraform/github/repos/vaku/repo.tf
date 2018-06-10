resource "github_repository" "repo" {
  name         = "vaku"
  description  = "A CLI and Go API to extend the official Vault client"
  homepage_url = "https://vaku.io/"

  default_branch = "master"
  private        = false

  has_wiki   = false
  has_issues = true

  allow_merge_commit = true
  allow_squash_merge = true
  allow_rebase_merge = true
}

resource "github_repository" "repo" {
  name        = "vaku"
  description = "Useful vault functions that extend the Hashicorp Vault Golang Client"

  default_branch = "master"
  private        = false

  has_wiki   = false
  has_issues = true

  allow_merge_commit = true
  allow_squash_merge = true
  allow_rebase_merge = true
}

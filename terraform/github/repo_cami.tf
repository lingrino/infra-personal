resource "github_repository" "cami" {
  name         = "cami"
  description  = "A CLI and API for cleaning up unused AWS AMIs"
  homepage_url = "https://lingrino.com"

  default_branch = "master"
  private        = false

  has_wiki   = false
  has_issues = true

  allow_merge_commit     = true
  allow_squash_merge     = true
  allow_rebase_merge     = true
  delete_branch_on_merge = true

  topics = [
    "aws",
    "ami",
    "cli",
    "go",
    "golang",
  ]
}

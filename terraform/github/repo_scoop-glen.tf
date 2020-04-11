resource "github_repository" "scoop-glen" {
  name         = "scoop-glen"
  description  = "Scoop bucket for glen binaries. Powered by @goreleaser"
  homepage_url = "https://lingrino.com/"

  default_branch = "master"
  private        = false

  has_wiki   = false
  has_issues = false

  allow_merge_commit     = true
  allow_squash_merge     = true
  allow_rebase_merge     = true
  delete_branch_on_merge = true

  topics = [
    "scoop",
    "glen",
  ]
}

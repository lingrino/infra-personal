resource "github_repository" "scoop-vaku" {
  name         = "scoop-vaku"
  description  = "Scoop bucket for vaku binaries. Powered by @goreleaser"
  homepage_url = "https://vaku.dev/"

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
    "vaku",
  ]
}

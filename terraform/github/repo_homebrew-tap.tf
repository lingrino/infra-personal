resource "github_repository" "homebrew-tap" {
  name         = "homebrew-tap"
  description  = "Homebrew Tap for my personal projects. Powered by @goreleaser"
  homepage_url = "https://lingrino.com/"

  default_branch = "main"
  private        = false

  has_wiki   = false
  has_issues = false

  allow_merge_commit     = true
  allow_squash_merge     = true
  allow_rebase_merge     = true
  delete_branch_on_merge = true

  topics = [
    "brew",
    "homebrew",
  ]
}

resource "github_repository" "homebrew-tap" {
  name         = "homebrew-tap"
  description  = "A Homebrew Tap for my personal projects"
  homepage_url = "https://srlingren.com"

  default_branch = "master"
  private        = false

  has_wiki   = false
  has_issues = false

  allow_merge_commit = true
  allow_squash_merge = true
  allow_rebase_merge = true

  topics = [
    "brew",
    "glen",
    "homebrew",
    "vaku",
  ]
}

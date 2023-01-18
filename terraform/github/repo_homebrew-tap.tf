resource "github_repository" "homebrew-tap" {
  name         = "homebrew-tap"
  description  = "Homebrew Tap for my personal projects. Powered by @goreleaser"
  homepage_url = "https://lingrino.com"

  visibility = "public"

  has_wiki             = false
  has_issues           = false
  has_projects         = false
  has_discussions      = false
  vulnerability_alerts = true

  allow_auto_merge       = true
  allow_merge_commit     = true
  allow_squash_merge     = true
  allow_rebase_merge     = true
  allow_update_branch    = true
  delete_branch_on_merge = true

  topics = [
    "brew",
    "homebrew",
  ]
}

resource "github_branch" "homebrew-tap" {
  repository = github_repository.homebrew-tap.name
  branch     = "main"
}

resource "github_branch_default" "homebrew-tap" {
  repository = github_repository.homebrew-tap.name
  branch     = github_branch.homebrew-tap.branch
}

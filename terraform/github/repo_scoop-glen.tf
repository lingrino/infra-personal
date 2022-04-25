resource "github_repository" "scoop-glen" {
  name         = "scoop-glen"
  description  = "Scoop bucket for glen binaries. Powered by @goreleaser"
  homepage_url = "https://lingrino.com"

  visibility = "public"

  has_wiki             = false
  has_issues           = false
  has_projects         = false
  vulnerability_alerts = true

  allow_auto_merge       = true
  allow_merge_commit     = true
  allow_squash_merge     = true
  allow_rebase_merge     = true
  delete_branch_on_merge = true

  topics = [
    "scoop",
    "glen",
  ]
}

resource "github_branch" "scoop-glen" {
  repository = github_repository.scoop-glen.name
  branch     = "main"
}

resource "github_branch_default" "scoop-glen" {
  repository = github_repository.scoop-glen.name
  branch     = github_branch.scoop-glen.branch
}

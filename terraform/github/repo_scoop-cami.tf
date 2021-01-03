resource "github_repository" "scoop-cami" {
  name         = "scoop-cami"
  description  = "Scoop bucket for cami binaries. Powered by @goreleaser"
  homepage_url = "https://lingrino.com"

  visibility = "public"

  has_wiki     = false
  has_issues   = false
  has_projects = false

  allow_merge_commit     = true
  allow_squash_merge     = true
  allow_rebase_merge     = true
  delete_branch_on_merge = true

  topics = [
    "scoop",
    "cami",
  ]
}

resource "github_branch" "scoop-cami" {
  repository = github_repository.scoop-cami.name
  branch     = "main"
}

resource "github_branch_default" "scoop-cami" {
  repository = github_repository.scoop-cami.name
  branch     = github_branch.scoop-cami.branch
}

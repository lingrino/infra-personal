resource "github_repository" "scoop-vaku" {
  name         = "scoop-vaku"
  description  = "Scoop bucket for vaku binaries. Powered by @goreleaser"
  homepage_url = "https://vaku.dev"

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
    "vaku",
  ]
}

resource "github_branch" "scoop-vaku" {
  repository = github_repository.scoop-vaku.name
  branch     = "main"
}

resource "github_branch_default" "scoop-vaku" {
  repository = github_repository.scoop-vaku.name
  branch     = github_branch.scoop-vaku.branch
}

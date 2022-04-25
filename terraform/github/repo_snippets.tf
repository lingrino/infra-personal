resource "github_repository" "snippets" {
  name         = "snippets"
  description  = "Useful code snippets not ready for OSS"
  homepage_url = "https://lingrino.com"

  visibility = "private"

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
    "ci",
    "docker",
    "snippets",
    "terraform",
  ]
}

resource "github_branch" "snippets" {
  repository = github_repository.snippets.name
  branch     = "main"
}

resource "github_branch_default" "snippets" {
  repository = github_repository.snippets.name
  branch     = github_branch.snippets.branch
}

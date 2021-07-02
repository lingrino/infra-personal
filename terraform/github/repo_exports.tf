resource "github_repository" "exports" {
  name         = "exports"
  description  = "A repo for storing exports from third party services I use"
  homepage_url = "https://lingrino.com"

  visibility = "private"

  has_wiki             = false
  has_issues           = false
  has_projects         = false
  vulnerability_alerts = true

  allow_merge_commit     = true
  allow_squash_merge     = true
  allow_rebase_merge     = true
  delete_branch_on_merge = true
}

resource "github_branch" "exports" {
  repository = github_repository.exports.name
  branch     = "main"
}

resource "github_branch_default" "exports" {
  repository = github_repository.exports.name
  branch     = github_branch.exports.branch
}

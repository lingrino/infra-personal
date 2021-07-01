resource "github_repository" "w" {
  name         = "w"
  description  = "a work in progress"
  homepage_url = "https://lingrino.com"

  visibility = "public"

  has_wiki             = false
  has_issues           = true
  has_projects         = false
  vulnerability_alerts = true

  allow_merge_commit     = true
  allow_squash_merge     = true
  allow_rebase_merge     = true
  delete_branch_on_merge = true

  topics = [
    "cli",
    "rust",
  ]
}

module "w-labels" {
  source = "../../terraform-modules/github-repo-labels//"
  repo   = github_repository.w.name
}

resource "github_branch" "w" {
  repository = github_repository.w.name
  branch     = "main"
}

resource "github_branch_default" "w" {
  repository = github_repository.w.name
  branch     = github_branch.w.branch
}

resource "github_branch_protection" "w" {
  repository_id  = github_repository.w.node_id
  pattern        = github_branch.w.branch
  enforce_admins = true
}

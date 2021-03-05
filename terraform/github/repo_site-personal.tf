resource "github_repository" "site-personal" {
  name         = "site-personal"
  description  = "My personal website"
  homepage_url = "https://lingrino.com"

  visibility = "public"

  has_wiki             = false
  has_issues           = false
  has_projects         = false
  vulnerability_alerts = true

  allow_merge_commit     = true
  allow_squash_merge     = true
  allow_rebase_merge     = true
  delete_branch_on_merge = true

  topics = [
    "html",
    "website",
  ]
}

module "site-personal-labels" {
  source = "../../terraform-modules/github-repo-labels//"
  repo   = github_repository.site-personal.name
}

resource "github_branch" "site-personal" {
  repository = github_repository.site-personal.name
  branch     = "main"
}

resource "github_branch_default" "site-personal" {
  repository = github_repository.site-personal.name
  branch     = github_branch.site-personal.branch
}

resource "github_repository" "site-personal" {
  name         = "site-personal"
  description  = "My personal website"
  homepage_url = "https://lingrino.com"

  default_branch = "main"
  private        = false

  has_wiki   = false
  has_issues = false

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

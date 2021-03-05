resource "github_repository" "dotfiles" {
  name         = "dotfiles"
  description  = "Maintain your local environment wth Ansible"
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
    "ansible",
    "automation",
    "dotfiles",
    "mac",
  ]
}

module "dotfiles-labels" {
  source = "../../terraform-modules/github-repo-labels//"
  repo   = github_repository.dotfiles.name
}

resource "github_branch" "dotfiles" {
  repository = github_repository.dotfiles.name
  branch     = "main"
}

resource "github_branch_default" "dotfiles" {
  repository = github_repository.dotfiles.name
  branch     = github_branch.dotfiles.branch
}

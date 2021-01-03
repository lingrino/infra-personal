resource "github_repository" "docker" {
  name         = "docker"
  description  = "My docker images"
  homepage_url = "https://lingrino.com"

  visibility = "public"
  archived   = true

  has_wiki     = false
  has_issues   = true
  has_projects = false

  allow_merge_commit     = true
  allow_squash_merge     = true
  allow_rebase_merge     = true
  delete_branch_on_merge = true

  topics = [
    "ci",
    "docker",
  ]
}

module "docker-labels" {
  source = "../../terraform-modules/github-repo-labels//"
  repo   = github_repository.docker.name
}

resource "github_branch" "docker" {
  repository = github_repository.docker.name
  branch     = "main"
}

resource "github_branch_default" "docker" {
  repository = github_repository.docker.name
  branch     = github_branch.docker.branch
}

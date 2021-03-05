resource "github_repository" "cami" {
  name         = "cami"
  description  = "A CLI and API for cleaning up unused AWS AMIs"
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
    "aws",
    "ami",
    "cli",
    "go",
    "golang",
  ]
}

module "cami-labels" {
  source = "../../terraform-modules/github-repo-labels//"
  repo   = github_repository.cami.name
}

resource "github_branch" "cami" {
  repository = github_repository.cami.name
  branch     = "main"
}

resource "github_branch_default" "cami" {
  repository = github_repository.cami.name
  branch     = github_branch.cami.branch
}

resource "github_branch_protection" "cami" {
  repository_id  = github_repository.cami.node_id
  pattern        = github_branch.cami.branch
  enforce_admins = true

  required_status_checks {
    strict = true
    contexts = [
      "golangci",
      "gomod",
      "goreleaser",
      "test",
      "validate",
    ]
  }
}

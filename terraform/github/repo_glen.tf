resource "github_repository" "glen" {
  name         = "glen"
  description  = "A CLI to gather GitLab project and group variables"
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
    "gitlab",
    "go",
    "golang",
  ]
}

module "glen-labels" {
  source = "../../terraform-modules/github-repo-labels//"
  repo   = github_repository.glen.name
}

resource "github_branch" "glen" {
  repository = github_repository.glen.name
  branch     = "main"
}

resource "github_branch_default" "glen" {
  repository = github_repository.glen.name
  branch     = github_branch.glen.branch
}

resource "github_branch_protection" "glen" {
  repository_id  = github_repository.glen.node_id
  pattern        = github_branch.glen.branch
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

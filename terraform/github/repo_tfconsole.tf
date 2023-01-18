resource "github_repository" "tfconsole" {
  name         = "tfconsole"
  description  = "it's `terraform console` but in the browser"
  homepage_url = "https://lingrino.com"

  visibility = "public"

  has_wiki             = false
  has_issues           = true
  has_projects         = false
  has_discussions      = false
  vulnerability_alerts = true

  allow_auto_merge       = true
  allow_merge_commit     = true
  allow_squash_merge     = true
  allow_rebase_merge     = true
  allow_update_branch    = true
  delete_branch_on_merge = true

  topics = [
    "cli",
    "gitlab",
    "go",
    "golang",
  ]
}

module "tfconsole-labels" {
  source = "../../terraform-modules/github-repo-labels//"
  repo   = github_repository.tfconsole.name
}

resource "github_branch" "tfconsole" {
  repository = github_repository.tfconsole.name
  branch     = "main"
}

resource "github_branch_default" "tfconsole" {
  repository = github_repository.tfconsole.name
  branch     = github_branch.tfconsole.branch
}

resource "github_branch_protection" "tfconsole" {
  repository_id  = github_repository.tfconsole.node_id
  pattern        = github_branch.tfconsole.branch
  enforce_admins = true

  required_status_checks {
    strict = true
    contexts = [
      "golangci",
      "gomod",
      "test",
      "validate",
    ]
  }
}

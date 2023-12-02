resource "github_repository" "vaku" {
  name         = "vaku"
  description  = "vaku extends the vault api & cli"
  homepage_url = "https://lingrino.com"

  visibility = "public"

  has_wiki             = false
  has_issues           = true
  has_projects         = false
  has_discussions      = false
  vulnerability_alerts = true

  allow_auto_merge       = true
  allow_merge_commit     = false
  allow_squash_merge     = true
  allow_rebase_merge     = false
  allow_update_branch    = true
  delete_branch_on_merge = true

  security_and_analysis {
    secret_scanning {
      status = "enabled"
    }
    secret_scanning_push_protection {
      status = "enabled"
    }
  }
}

resource "github_branch" "vaku" {
  repository = github_repository.vaku.name
  branch     = "main"
}

resource "github_branch_default" "vaku" {
  repository = github_repository.vaku.name
  branch     = github_branch.vaku.branch
}

resource "github_branch_protection" "vaku" {
  repository_id  = github_repository.vaku.node_id
  pattern        = github_branch.vaku.branch
  enforce_admins = true

  required_status_checks {
    strict = true
    contexts = [
      "docs",
      "golangci",
      "gomod",
      "goreleaser",
      "test",
      "validate",
    ]
  }
}

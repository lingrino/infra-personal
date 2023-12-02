resource "github_repository" "uptime" {
  name         = "uptime"
  description  = "uptime calculator"
  homepage_url = "https://uptime.how"

  visibility = "public"

  has_wiki             = false
  has_issues           = false
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

resource "github_branch" "uptime" {
  repository = github_repository.uptime.name
  branch     = "main"
}

resource "github_branch_default" "uptime" {
  repository = github_repository.uptime.name
  branch     = github_branch.uptime.branch
}

resource "github_branch_protection" "uptime" {
  repository_id  = github_repository.uptime.node_id
  pattern        = github_branch.uptime.branch
  enforce_admins = true

  required_status_checks {
    strict = true
    contexts = [
      "lint",
      "test",
      "format",
      "Cloudflare Pages",
    ]
  }
}

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

resource "github_repository_ruleset" "uptime" {
  name        = "main"
  repository  = github_repository.uptime.name
  target      = "branch"
  enforcement = "active"

  conditions {
    ref_name {
      include = ["~DEFAULT_BRANCH"]
      exclude = []
    }
  }

  rules {
    deletion = true

    required_linear_history = true
    non_fast_forward        = true

    pull_request {}

    required_status_checks {
      strict_required_status_checks_policy = true

      dynamic "required_check" {
        for_each = ["Cloudflare Pages", "format", "lint", "test"]

        content {
          context        = required_check.value
          integration_id = 0
        }
      }
    }
  }
}

resource "github_actions_repository_permissions" "uptime" {
  repository      = github_repository.uptime.name
  allowed_actions = "all"
}

resource "github_repository_dependabot_security_updates" "uptime" {
  repository = github_repository.uptime.id
  enabled    = true
}

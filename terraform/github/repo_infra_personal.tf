resource "github_repository" "infra_personal" {
  name         = "infra-personal"
  description  = "code for setting up my personal infrastructure"
  homepage_url = "https://lingrino.com"

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

resource "github_branch" "infra_personal" {
  repository = github_repository.infra_personal.name
  branch     = "main"
}

resource "github_branch_default" "infra_personal" {
  repository = github_repository.infra_personal.name
  branch     = github_branch.infra_personal.branch
}

resource "github_repository_ruleset" "infra_personal" {
  name        = "main"
  repository  = github_repository.infra_personal.name
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
        for_each = [
          "Terraform Cloud/lingrino/aws-accounts-audit",
          "Terraform Cloud/lingrino/aws-accounts-auth",
          "Terraform Cloud/lingrino/aws-accounts-dev",
          "Terraform Cloud/lingrino/aws-accounts-prod",
          "Terraform Cloud/lingrino/aws-accounts-root",
          "Terraform Cloud/lingrino/aws-common-organization",
          "Terraform Cloud/lingrino/b2",
          "Terraform Cloud/lingrino/cloudflare",
          "Terraform Cloud/lingrino/github",
          "Terraform Cloud/lingrino/tailscale",
          "Terraform Cloud/lingrino/terraform",
          "validate"
        ]

        content {
          context        = required_check.value
          integration_id = 0
        }
      }
    }
  }
}

resource "github_actions_repository_permissions" "infra_personal" {
  repository      = github_repository.infra_personal.name
  allowed_actions = "all"
}

resource "github_repository_dependabot_security_updates" "infra_personal" {
  repository = github_repository.infra_personal.id
  enabled    = true
}

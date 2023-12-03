resource "github_repository" "infra_personal" {
  name         = "infra-personal"
  description  = "Terraform for setting up my personal infrastructure"
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

resource "github_branch_protection" "infra_personal" {
  repository_id  = github_repository.infra_personal.node_id
  pattern        = github_branch.infra_personal.branch
  enforce_admins = true

  required_status_checks {
    strict = true
    contexts = [
      "Terraform Cloud/lingrino/aws-accounts-audit",
      "Terraform Cloud/lingrino/aws-accounts-auth",
      "Terraform Cloud/lingrino/aws-accounts-dev",
      "Terraform Cloud/lingrino/aws-accounts-prod",
      "Terraform Cloud/lingrino/aws-accounts-root",
      "Terraform Cloud/lingrino/aws-common-organization",
      "Terraform Cloud/lingrino/cloudflare",
      "Terraform Cloud/lingrino/github",
      "Terraform Cloud/lingrino/tailscale",
      "Terraform Cloud/lingrino/terraform",
      "validate"
    ]
  }
}

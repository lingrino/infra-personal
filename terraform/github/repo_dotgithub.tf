resource "github_repository" "dotgithub" {
  name         = ".github"
  description  = "my default community health files"
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

resource "github_branch" "dotgithub" {
  repository = github_repository.dotgithub.name
  branch     = "main"
}

resource "github_branch_default" "dotgithub" {
  repository = github_repository.dotgithub.name
  branch     = github_branch.dotgithub.branch
}

resource "github_branch_protection" "dotgithub" {
  repository_id           = github_repository.dotgithub.node_id
  pattern                 = github_branch.dotgithub.branch
  enforce_admins          = true
  required_linear_history = true

  required_status_checks {
    strict = true
    contexts = [
      "validate",
    ]
  }
}

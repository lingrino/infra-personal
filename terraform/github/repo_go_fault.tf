resource "github_repository" "go_fault" {
  name         = "go-fault"
  description  = "fault injection library in go using standard http middleware"
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

resource "github_branch" "go_fault" {
  repository = github_repository.go_fault.name
  branch     = "main"
}

resource "github_branch_default" "go_fault" {
  repository = github_repository.go_fault.name
  branch     = github_branch.go_fault.branch
}

resource "github_branch_protection" "go_fault" {
  repository_id           = github_repository.go_fault.node_id
  pattern                 = github_branch.go_fault.branch
  enforce_admins          = true
  required_linear_history = true

  required_status_checks {
    strict = true
    contexts = [
      "validate (ubuntu-latest, stable)",
    ]
  }
}

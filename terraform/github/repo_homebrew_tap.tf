resource "github_repository" "homebrew_tap" {
  name         = "homebrew-tap"
  description  = "homebrew tap for my personal projects"
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

resource "github_branch" "homebrew_tap" {
  repository = github_repository.homebrew_tap.name
  branch     = "main"
}

resource "github_branch_default" "homebrew_tap" {
  repository = github_repository.homebrew_tap.name
  branch     = github_branch.homebrew_tap.branch
}

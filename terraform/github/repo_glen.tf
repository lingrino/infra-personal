resource "github_repository" "glen" {
  name         = "glen"
  description  = "A CLI to gather GitLab project and group variables"
  homepage_url = "https://lingrino.com"

  default_branch = "master"
  private        = false

  has_wiki   = false
  has_issues = true

  allow_merge_commit = true
  allow_squash_merge = true
  allow_rebase_merge = true

  topics = [
    "cli",
    "gitlab",
    "go",
    "golang",
  ]
}

resource "github_branch_protection" "glen" {
  repository     = github_repository.glen.name
  branch         = "master"
  enforce_admins = true

  required_status_checks {
    strict = true
    contexts = [
      "validate"
    ]
  }
}

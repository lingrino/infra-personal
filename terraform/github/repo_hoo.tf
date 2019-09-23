resource "github_repository" "hoo" {
  name         = "hoo"
  description  = "A CLI for determining who you are"
  homepage_url = "https://lingrino.com"

  default_branch = "master"
  private        = true

  has_wiki   = false
  has_issues = true

  allow_merge_commit = true
  allow_squash_merge = true
  allow_rebase_merge = true

  topics = [
    "aws",
    "cli",
    "gitlab",
    "go",
    "golang",
    "whoami",
  ]
}

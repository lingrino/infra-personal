resource "github_repository" "snippets" {
  name         = "snippets"
  description  = "Useful code snippets not ready for OSS"
  homepage_url = "https://lingrino.com"

  default_branch = "main"
  visibility     = "private"

  has_wiki     = false
  has_issues   = false
  has_projects = false

  allow_merge_commit     = true
  allow_squash_merge     = true
  allow_rebase_merge     = true
  delete_branch_on_merge = true

  topics = [
    "ci",
    "docker",
    "snippets",
    "terraform",
  ]
}

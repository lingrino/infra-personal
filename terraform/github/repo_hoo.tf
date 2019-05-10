# resource "github_branch_protection" "hoo" {
#   repository     = "${ github_repository.hoo.name }"
#   branch         = "master"
#   enforce_admins = true
#
#   required_status_checks {
#     strict   = true
#     contexts = ["ci/gitlab/gitlab.com"]
#   }
# }
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

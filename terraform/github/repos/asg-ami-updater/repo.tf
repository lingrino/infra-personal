resource "github_repository" "repo" {
  name        = "asg-ami-updater"
  description = "Continuously update ASGs with new AWS AMIs"

  default_branch = "master"
  private        = false

  has_wiki   = false
  has_issues = false

  allow_merge_commit = true
  allow_squash_merge = true
  allow_rebase_merge = true
}

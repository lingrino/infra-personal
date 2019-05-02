resource "github_repository" "dotfiles" {
  name         = "dotfiles"
  description  = "My Dotfiles"
  homepage_url = "https://srlingren.com"

  default_branch = "master"
  private        = false

  has_wiki   = false
  has_issues = true

  allow_merge_commit = true
  allow_squash_merge = true
  allow_rebase_merge = true

  topics = [
    "ansible",
    "automation",
    "dotfiles",
    "mac",
  ]
}

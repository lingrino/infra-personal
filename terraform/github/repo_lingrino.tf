resource "github_repository" "lingrino" {
  name        = "lingrino"
  description = "my readme profile"

  visibility = "public"

  has_wiki             = false
  has_issues           = false
  has_projects         = false
  vulnerability_alerts = true

  allow_merge_commit     = true
  allow_squash_merge     = true
  allow_rebase_merge     = true
  delete_branch_on_merge = true
}

resource "github_branch" "lingrino" {
  repository = github_repository.lingrino.name
  branch     = "main"
}

resource "github_branch_default" "lingrino" {
  repository = github_repository.lingrino.name
  branch     = github_branch.lingrino.branch
}

resource "github_repository" "dotgithub" {
  name        = ".github"
  description = "My Default Community Health Files"

  default_branch = "main"
  visibility     = "public"

  has_wiki     = false
  has_issues   = true
  has_projects = false

  allow_merge_commit     = true
  allow_squash_merge     = true
  allow_rebase_merge     = true
  delete_branch_on_merge = true
}

module "dotgithub-labels" {
  source = "../../terraform-modules/github-repo-labels//"
  repo   = github_repository.dotgithub.name
}

resource "github_branch_protection" "dotgithub" {
  repository     = github_repository.dotgithub.node_id
  pattern        = "main"
  enforce_admins = true

  required_status_checks {
    strict = true
    contexts = [
      "validate",
    ]
  }
}

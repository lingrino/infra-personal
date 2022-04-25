resource "github_repository" "vaku" {
  name         = "vaku"
  description  = "Vaku extends the Vault API & CLI"
  homepage_url = "https://vaku.dev"

  visibility = "public"

  has_wiki             = false
  has_issues           = true
  has_projects         = false
  vulnerability_alerts = true

  allow_auto_merge       = true
  allow_merge_commit     = true
  allow_squash_merge     = true
  allow_rebase_merge     = true
  delete_branch_on_merge = true

  topics = [
    "cli",
    "go",
    "golang",
    "vault",
    "vault-api",
    "vault-client",
  ]
}

module "vaku-labels" {
  source = "../../terraform-modules/github-repo-labels//"
  repo   = github_repository.vaku.name
}

resource "github_branch" "vaku" {
  repository = github_repository.vaku.name
  branch     = "main"
}

resource "github_branch_default" "vaku" {
  repository = github_repository.vaku.name
  branch     = github_branch.vaku.branch
}

resource "github_branch_protection" "vaku" {
  repository_id  = github_repository.vaku.node_id
  pattern        = github_branch.vaku.branch
  enforce_admins = true

  required_status_checks {
    strict = true
    contexts = [
      "docs",
      "golangci",
      "gomod",
      "goreleaser",
      "test",
      "validate",
    ]
  }
}

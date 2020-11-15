resource "github_repository" "vaku" {
  name         = "vaku"
  description  = "Vaku extends the Vault API & CLI"
  homepage_url = "https://vaku.dev"

  default_branch = "main"
  visibility     = "public"

  has_wiki     = false
  has_issues   = true
  has_projects = false

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

resource "github_branch_protection" "vaku" {
  repository_id  = github_repository.vaku.node_id
  pattern        = "main"
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

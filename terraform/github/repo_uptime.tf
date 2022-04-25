resource "github_repository" "uptime" {
  name         = "uptime"
  description  = "Uptime Calculator"
  homepage_url = "https://uptime.how"

  visibility = "public"

  has_wiki             = false
  has_issues           = false
  has_projects         = false
  vulnerability_alerts = true

  allow_auto_merge       = true
  allow_merge_commit     = true
  allow_squash_merge     = true
  allow_rebase_merge     = true
  delete_branch_on_merge = true

  topics = [
    "svelte",
    "tailwind",
    "snowpack",
    "sla",
    "slo",
    "reliability",
  ]
}

module "uptime-labels" {
  source = "../../terraform-modules/github-repo-labels//"
  repo   = github_repository.uptime.name
}

resource "github_branch" "uptime" {
  repository = github_repository.uptime.name
  branch     = "main"
}

resource "github_branch_default" "uptime" {
  repository = github_repository.uptime.name
  branch     = github_branch.uptime.branch
}

resource "github_branch_protection" "uptime" {
  repository_id  = github_repository.uptime.node_id
  pattern        = github_branch.uptime.branch
  enforce_admins = true

  required_status_checks {
    strict = true
    contexts = [
      "lint",
      "test",
      "format",
      "Cloudflare Pages",
    ]
  }
}

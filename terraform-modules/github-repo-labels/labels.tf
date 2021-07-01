resource "github_issue_label" "actions" {
  repository = var.repo

  name        = "actions"
  color       = "102F5F"
  description = "Pull requests that update actions"
}

resource "github_issue_label" "ansible" {
  repository = var.repo

  name        = "ansible"
  color       = "000000"
  description = "Pull requests that update ansible"
}

resource "github_issue_label" "dependencies" {
  repository = var.repo

  name        = "dependencies"
  color       = "0366D6"
  description = "Pull requests that update dependencies"
}

resource "github_issue_label" "docker" {
  repository = var.repo

  name        = "docker"
  color       = "3E92DC"
  description = "Pull requests that update docker"
}

resource "github_issue_label" "go" {
  repository = var.repo

  name        = "go"
  color       = "4CABD3"
  description = "Pull requests that update go code"
}

resource "github_issue_label" "javascript" {
  repository = var.repo

  name        = "javascript"
  color       = "FCDC00"
  description = "Pull requests that update javascript code"
}

resource "github_issue_label" "rust" {
  repository = var.repo

  name        = "rust"
  color       = "E55940"
  description = "Pull requests that update rust code"
}

resource "github_issue_label" "terraform" {
  repository = var.repo

  name        = "terraform"
  color       = "5C44DB"
  description = "Pull requests that update terraform"
}

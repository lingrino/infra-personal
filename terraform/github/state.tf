terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "lingrino"

    workspaces {
      name = "github"
    }
  }
}

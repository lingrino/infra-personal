terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "lingrino"

    workspaces {
      name = "aws-accounts-audit"
    }
  }
}

data "terraform_remote_state" "organization" {
  backend = "remote"

  config = {
    organization = "lingrino"

    workspaces = {
      name = "aws-common-organization"
    }
  }
}

terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "lingrino"

    workspaces {
      name = "aws-accounts-auth"
    }
  }
}

data "terraform_remote_state" "terraform" {
  backend = "remote"

  config = {
    organization = "lingrino"

    workspaces = {
      name = "terraform"
    }
  }
}

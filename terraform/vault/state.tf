terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "lingrino"

    workspaces {
      name = "vault"
    }
  }

  required_providers {
    tfe = {
      source = "hashicorp/tfe"
    }
    vault = {
      source = "hashicorp/vault"
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

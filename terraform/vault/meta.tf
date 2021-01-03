#################################
### Providers                 ###
#################################
provider "tfe" {}
provider "vault" {
  address = "https://vault.lingrino.dev"
}

#################################
### Terraform                 ###
#################################
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

#################################
### Remote State              ###
#################################
data "terraform_remote_state" "terraform" {
  backend = "remote"

  config = {
    organization = "lingrino"

    workspaces = {
      name = "terraform"
    }
  }
}

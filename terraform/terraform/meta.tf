#################################
### Providers                 ###
#################################
provider "tfe" {}

#################################
### Terraform                 ###
#################################
terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "lingrino"

    workspaces {
      name = "terraform"
    }
  }

  required_providers {
    tfe = {
      source = "hashicorp/tfe"
    }
  }
}

#################################
### Providers                 ###
#################################
provider "tfe" {}

#################################
### Terraform                 ###
#################################
terraform {
  backend "cloud" {
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

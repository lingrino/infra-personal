#################################
### Providers                 ###
#################################
provider "b2" {}

#################################
### Terraform                 ###
#################################
terraform {
  cloud {
    organization = "lingrino"

    workspaces {
      name = "b2"
    }
  }

  required_providers {
    b2 = {
      source = "Backblaze/b2"
    }
  }
}

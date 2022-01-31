#################################
### Providers                 ###
#################################
provider "digitalocean" {}

#################################
### Terraform                 ###
#################################
terraform {
  backend "cloud" {
    organization = "lingrino"

    workspaces {
      name = "do"
    }
  }

  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
  }
}

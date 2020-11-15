#################################
### Providers                 ###
#################################
provider "tls" {}

#################################
### Terraform                 ###
#################################
terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "lingrino"

    workspaces {
      name = "tls"
    }
  }

  required_providers {
    tls = {
      source = "hashicorp/tls"
    }
  }
}

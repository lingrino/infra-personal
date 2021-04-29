#################################
### Providers                 ###
#################################
provider "tailscale" {
  domain = "lingrino.com"
}

#################################
### Terraform                 ###
#################################
terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "lingrino"

    workspaces {
      name = "tailscale"
    }
  }

  required_providers {
    tailscale = {
      source = "davidsbond/tailscale"
    }
  }
}

#################################
### Providers                 ###
#################################
provider "tailscale" {
  tailnet = "lingrino.github"
}

#################################
### Terraform                 ###
#################################
terraform {
  backend "cloud" {
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

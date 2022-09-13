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
  cloud {
    organization = "lingrino"

    workspaces {
      name = "tailscale"
    }
  }

  required_providers {
    tailscale = {
      source = "tailscale/tailscale"
    }
  }
}

#################################
### Providers                 ###
#################################
provider "cloudflare" {}

#################################
### Terraform                 ###
#################################
terraform {
  cloud {
    organization = "lingrino"

    workspaces {
      name = "cloudflare"
    }
  }

  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
  }
}

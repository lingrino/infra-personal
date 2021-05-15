#################################
### Providers                 ###
#################################
provider "github" {
  organization = "lingrino-org"
}

#################################
### Terraform                 ###
#################################
terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "lingrino"

    workspaces {
      name = "github-lingrino-org"
    }
  }

  required_providers {
    github = {
      source = "integrations/github"
    }
  }
}

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
  cloud {
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

#################################
### Providers                 ###
#################################
provider "github" {
  owner = "lingrino"
}

#################################
### Terraform                 ###
#################################
terraform {
  cloud {
    organization = "lingrino"

    workspaces {
      name = "github"
    }
  }

  required_providers {
    github = {
      source = "integrations/github"
    }
  }
}

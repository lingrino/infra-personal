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

#################################
### Remote State              ###
#################################
data "terraform_remote_state" "account_auth" {
  backend = "remote"

  config = {
    organization = "lingrino"

    workspaces = {
      name = "aws-accounts-auth"
    }
  }
}

data "terraform_remote_state" "account_prod" {
  backend = "remote"

  config = {
    organization = "lingrino"

    workspaces = {
      name = "aws-accounts-prod"
    }
  }
}

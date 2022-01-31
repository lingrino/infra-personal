#################################
### Providers                 ###
#################################
provider "aws" {
  region              = "us-east-1"
  allowed_account_ids = [var.account_id_auth]

  assume_role {
    role_arn     = "arn:aws:iam::${var.account_id_auth}:role/${var.assume_role_name}"
    session_name = var.assume_role_session_name
  }

  default_tags {
    tags = {
      terraform = "true"
    }
  }
}

provider "tfe" {}

#################################
### Terraform                 ###
#################################
terraform {
  backend "cloud" {
    organization = "lingrino"

    workspaces {
      name = "aws-accounts-auth"
    }
  }

  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    tfe = {
      source = "hashicorp/tfe"
    }
  }
}

#################################
### Remote State              ###
#################################
data "terraform_remote_state" "terraform" {
  backend = "remote"

  config = {
    organization = "lingrino"

    workspaces = {
      name = "terraform"
    }
  }
}

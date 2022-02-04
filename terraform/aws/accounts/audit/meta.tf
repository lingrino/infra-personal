#################################
### Providers                 ###
#################################
provider "aws" {
  region              = "us-east-1"
  allowed_account_ids = [var.account_id_audit]

  assume_role {
    role_arn     = "arn:aws:iam::${var.account_id_audit}:role/${var.assume_role_name}"
    session_name = var.assume_role_session_name
  }

  default_tags {
    tags = {
      terraform = "true"
    }
  }
}

#################################
### Terraform                 ###
#################################
terraform {
  cloud {
    organization = "lingrino"

    workspaces {
      name = "aws-accounts-audit"
    }
  }

  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

#################################
### Remote State              ###
#################################
data "terraform_remote_state" "organization" {
  backend = "remote"

  config = {
    organization = "lingrino"

    workspaces = {
      name = "aws-common-organization"
    }
  }
}

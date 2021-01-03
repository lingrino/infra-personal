#################################
### Providers                 ###
#################################
provider "aws" {
  region              = "us-east-1"
  allowed_account_ids = [var.account_id_dev]

  assume_role {
    role_arn     = "arn:aws:iam::${var.account_id_dev}:role/${var.assume_role_name}"
    session_name = var.assume_role_session_name
  }
}

#################################
### Terraform                 ###
#################################
terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "lingrino"

    workspaces {
      name = "aws-accounts-dev"
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
data "terraform_remote_state" "account_audit" {
  backend = "remote"

  config = {
    organization = "lingrino"

    workspaces = {
      name = "aws-accounts-audit"
    }
  }
}

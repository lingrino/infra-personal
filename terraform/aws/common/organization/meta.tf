#################################
### Providers                 ###
#################################
provider "aws" {
  region              = "us-east-1"
  allowed_account_ids = [var.account_id_root]

  assume_role {
    role_arn     = "arn:aws:iam::${var.account_id_root}:role/${var.assume_role_name}"
    session_name = var.assume_role_session_name
  }

  default_tags {
    terraform = true
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
      name = "aws-common-organization"
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

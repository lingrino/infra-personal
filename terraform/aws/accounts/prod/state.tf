terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "lingrino"

    workspaces {
      name = "aws-accounts-prod"
    }
  }

  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    tls = {
      source = "hashicorp/tls"
    }
  }
}

data "terraform_remote_state" "organization" {
  backend = "remote"

  config = {
    organization = "lingrino"

    workspaces = {
      name = "aws-common-organization"
    }
  }
}

data "terraform_remote_state" "account_audit" {
  backend = "remote"

  config = {
    organization = "lingrino"

    workspaces = {
      name = "aws-accounts-audit"
    }
  }
}

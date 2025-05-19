#################################
### Providers                 ###
#################################
provider "aws" {
  region = "us-west-2"

  profile             = !can(var.tfc_aws_dynamic_credentials.aliases["root"]) ? "root" : null
  shared_config_files = try([var.tfc_aws_dynamic_credentials.aliases["root"].shared_config_file], null)

  default_tags {
    tags = {
      terraform = "true"
      workspace = "aws-accounts-root"
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
      name = "aws-accounts-root"
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

#################################
### Providers                 ###
#################################
provider "aws" {
  region = "us-west-2"

  profile             = !can(var.tfc_aws_dynamic_credentials.aliases["auth"]) ? "auth" : null
  shared_config_files = try([var.tfc_aws_dynamic_credentials.aliases["auth"].shared_config_file], null)

  default_tags {
    tags = {
      terraform = "true"
      workspace = "aws-accounts-auth"
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
      name = "aws-accounts-auth"
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
data "terraform_remote_state" "common_organization" {
  backend = "remote"

  config = {
    organization = "lingrino"

    workspaces = {
      name = "aws-common-organization"
    }
  }
}

#################################
### Providers                 ###
#################################
provider "aws" {
  region = "us-east-1"

  shared_config_files = try([var.tfc_aws_dynamic_credentials.aliases["auth"].shared_config_file], null)

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
      name = "aws-common-organization"
    }
  }

  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

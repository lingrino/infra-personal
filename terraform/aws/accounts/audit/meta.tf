#################################
### Providers                 ###
#################################
provider "aws" {
  region = "us-east-1"

  shared_config_files = [var.tfc_aws_dynamic_credentials.aliases["audit"].shared_config_file]

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

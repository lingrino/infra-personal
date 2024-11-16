#################################
### Providers                 ###
#################################
provider "aws" {
  region = "us-east-1"

  shared_config_files = [var.tfc_aws_dynamic_credentials.aliases["auth"].shared_config_file]

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
    tfe = {
      source = "hashicorp/tfe"
    }
  }
}

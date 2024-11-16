#################################
### Providers                 ###
#################################
provider "aws" {
  region = "us-east-1"

  shared_config_files = try([var.tfc_aws_dynamic_credentials.aliases["dev"].shared_config_file], null)

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
      name = "aws-accounts-dev"
    }
  }

  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

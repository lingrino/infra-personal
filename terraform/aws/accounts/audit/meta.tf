#################################
### Providers                 ###
#################################
provider "aws" {
  region = "us-west-2"

  profile             = !can(var.tfc_aws_dynamic_credentials.aliases["audit"]) ? "audit" : null
  shared_config_files = try([var.tfc_aws_dynamic_credentials.aliases["audit"].shared_config_file], null)

  default_tags {
    tags = {
      terraform = "true"
      workspace = "aws-accounts-audit"
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

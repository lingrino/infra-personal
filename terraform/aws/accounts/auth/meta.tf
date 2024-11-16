#################################
### Providers                 ###
#################################
provider "aws" {
  region = "us-east-1"

  profile             = !can(var.tfc_aws_dynamic_credentials.aliases["auth"]) ? "auth" : null
  shared_config_files = try([var.tfc_aws_dynamic_credentials.aliases["auth"].shared_config_file], null)

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

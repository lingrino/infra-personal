#################################
### Providers                 ###
#################################
provider "b2" {}

provider "aws" {
  region = "us-west-2"

  profile             = !can(var.tfc_aws_dynamic_credentials.aliases["prod"]) ? "prod" : null
  shared_config_files = try([var.tfc_aws_dynamic_credentials.aliases["prod"].shared_config_file], null)

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
      name = "b2"
    }
  }

  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    b2 = {
      source = "Backblaze/b2"
    }
  }
}

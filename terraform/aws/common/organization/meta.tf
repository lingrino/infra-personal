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
      workspace = "aws-common-organization"
    }
  }
}

ephemeral "aws_secretsmanager_secret_version" "tfe" {
  provider  = aws.prod
  secret_id = "terraform-cloud/keys/terraform-cloud"
}

provider "tfe" {
  token = jsondecode(ephemeral.aws_secretsmanager_secret_version.tfe.secret_string)["TFE_TOKEN"]
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

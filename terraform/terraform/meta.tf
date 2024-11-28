#################################
### Providers                 ###
#################################
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

ephemeral "aws_secretsmanager_secret_version" "tfe" {
  secret_id = "terraform-cloud/keys/terraform-cloud"
}

provider "tfe" {
  token = jsondecode(data.aws_secretsmanager_secret_version.tfe.secret_string)["TFE_TOKEN"]
}

#################################
### Terraform                 ###
#################################
terraform {
  cloud {
    organization = "lingrino"

    workspaces {
      name = "terraform"
    }
  }

  required_providers {
    tfe = {
      source = "hashicorp/tfe"
    }
  }
}

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

ephemeral "aws_secretsmanager_secret_version" "backblaze" {
  secret_id = "backblaze/keys/terraform-cloud"
}

provider "b2" {
  application_key_id = jsondecode(ephemeral.aws_secretsmanager_secret_version.backblaze.secret_string)["B2_APPLICATION_KEY_ID"]
  application_key    = jsondecode(ephemeral.aws_secretsmanager_secret_version.backblaze.secret_string)["B2_APPLICATION_KEY"]
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

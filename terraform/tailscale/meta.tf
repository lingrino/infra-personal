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

data "aws_secretsmanager_secret_version" "tailscale" {
  secret_id = "tailscale/keys/terraform-cloud"
}

provider "tailscale" {
  tailnet = "lingrino.github"
  api_key = jsondecode(data.aws_secretsmanager_secret_version.tailscale.secret_string)["TAILSCALE_API_KEY"]
}

#################################
### Terraform                 ###
#################################
terraform {
  cloud {
    organization = "lingrino"

    workspaces {
      name = "tailscale"
    }
  }

  required_providers {
    tailscale = {
      source = "tailscale/tailscale"
    }
  }
}

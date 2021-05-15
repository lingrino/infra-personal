#################################
### Providers                 ###
#################################
provider "cloudflare" {
  account_id = var.cloudflare_account_id
}

provider "aws" {
  region = "us-east-1"

  assume_role {
    role_arn     = "arn:aws:iam::840856573771:role/${var.assume_role_name}"
    session_name = var.assume_role_session_name
  }

  default_tags {
    terraform = "true"
  }
}

provider "aws" {
  alias  = "audit"
  region = "us-east-1"

  assume_role {
    role_arn     = "arn:aws:iam::418875065733:role/${var.assume_role_name}"
    session_name = var.assume_role_session_name
  }

  default_tags {
    terraform = "true"
  }
}

#################################
### Terraform                 ###
#################################
terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "lingrino"

    workspaces {
      name = "cloudflare"
    }
  }

  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
  }
}

#################################
### Remote State              ###
#################################
data "terraform_remote_state" "account_audit" {
  backend = "remote"

  config = {
    organization = "lingrino"

    workspaces = {
      name = "aws-accounts-audit"
    }
  }
}

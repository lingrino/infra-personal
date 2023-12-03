provider "aws" {
  alias  = "auth"
  region = "us-east-1"

  assume_role {
    role_arn = "arn:aws:iam::${module.account_auth.id}:role/${var.assume_role_name}"
  }

  default_tags {
    tags = {
      terraform = "true"
    }
  }
}

module "account_auth" {
  source = "../../../../terraform-modules/account//"

  name  = "auth"
  email = "sean+aws-auth@lingrino.com"
}

module "account_auth_base" {
  source = "../../../../terraform-modules/account-base//"

  account_id   = module.account_auth.id
  account_name = module.account_auth.name

  account_id_audit = module.account_audit.id
  account_id_auth  = module.account_auth.id

  providers = {
    aws = aws.auth
  }
}

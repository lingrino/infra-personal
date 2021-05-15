provider "aws" {
  alias  = "prod"
  region = "us-east-1"

  assume_role {
    role_arn = "arn:aws:iam::${module.account_prod.id}:role/${var.assume_role_name}"
  }

  default_tags {
    terraform = "true"
  }
}

module "account_prod" {
  source = "../../../../terraform-modules/account//"

  name  = "prod"
  email = "sean+aws-prod@lingrino.com"
}

module "account_prod_base" {
  source = "../../../../terraform-modules/account-base//"

  account_id   = module.account_prod.id
  account_name = module.account_prod.name

  account_id_audit  = module.account_audit.id
  account_id_auth   = module.account_auth.id
  bucket_config_arn = data.terraform_remote_state.account_audit.outputs.bucket_config_arn

  vantage_id           = var.vantage_id
  vantage_handshake_id = var.vantage_handshake_id

  providers = {
    aws = aws.prod
  }
}

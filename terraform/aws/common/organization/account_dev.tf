provider "aws" {
  alias  = "dev"
  region = "us-east-1"

  assume_role {
    role_arn = "arn:aws:iam::${module.account_dev.id}:role/${var.assume_role_name}"
  }
}

module "account_dev" {
  source = "../../../../terraform-modules/account//"

  name  = "dev"
  email = "sean+aws-dev@lingrino.com"
  tags  = var.tags
}

module "account_dev_base" {
  source = "../../../../terraform-modules/account-base//"

  account_id   = module.account_dev.id
  account_name = module.account_dev.name

  account_id_audit  = module.account_audit.id
  account_id_auth   = module.account_auth.id
  bucket_config_arn = data.terraform_remote_state.account_audit.outputs.bucket_config_arn

  vantage_id           = var.vantage_id
  vantage_handshake_id = var.vantage_handshake_id

  tags = var.tags

  providers = {
    aws = aws.dev
  }
}

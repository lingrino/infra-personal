provider "aws" {
  alias  = "auth"
  region = "us-east-1"

  assume_role {
    role_arn = "arn:aws:iam::${module.account_auth.id}:role/${var.assume_role_name}"
  }
}

module "account_auth" {
  source = "../../../../terraform-modules/account//"

  name  = "auth"
  email = "srlingren+aws-auth@gmail.com"
  tags  = var.tags
}

module "account_auth_base" {
  source = "../../../../terraform-modules/account-base//"

  account_id   = module.account_auth.id
  account_name = module.account_auth.name

  account_id_auth   = module.account_auth.id
  bucket_config_arn = data.terraform_remote_state.account_audit.outputs.bucket_config_arn

  tags = var.tags

  providers = {
    aws = aws.auth
  }
}

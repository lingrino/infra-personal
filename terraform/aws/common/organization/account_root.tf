provider "aws" {
  alias  = "root"
  region = "us-east-1"

  assume_role {
    role_arn = "arn:aws:iam::${module.account_root.id}:role/${var.assume_role_name}"
  }
}

module "account_root" {
  source = "../../../../terraform-modules/account//"

  name  = "root"
  email = "sean+aws-root@lingrino.com"
  tags  = var.tags
}

module "account_root_base" {
  source = "../../../../terraform-modules/account-base//"

  account_id   = module.account_root.id
  account_name = module.account_root.name

  account_id_audit  = module.account_audit.id
  account_id_auth   = module.account_auth.id
  bucket_config_arn = data.terraform_remote_state.account_audit.outputs.bucket_config_arn

  vantage_id           = var.vantage_id
  vantage_handshake_id = var.vantage_handshake_id

  tags = var.tags

  providers = {
    aws = aws.root
  }
}

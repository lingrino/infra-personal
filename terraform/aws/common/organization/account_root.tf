provider "aws" {
  alias  = "root"
  region = "us-east-1"

  assume_role {
    role_arn = "arn:aws:iam::${ module.account_root.id }:role/OrganizationAccountAccessRole"
  }
}

module "account_root" {
  source = "../../../../terraform-modules/account//"

  name  = "root"
  email = "srlingren+aws-root@gmail.com"
}

module "account_root_base" {
  source = "../../../../terraform-modules/account-base//"

  account_id   = "${ module.account_root.id }"
  account_name = "${ module.account_root.name }"

  account_id_auth   = "${ module.account_auth.id }"
  bucket_config_arn = "${ data.terraform_remote_state.account_audit.bucket_config_arn }"

  tags = "${ var.tags }"

  providers {
    aws = "aws.root"
  }
}

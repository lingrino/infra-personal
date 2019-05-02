provider "aws" {
  alias  = "auth"
  region = "us-east-1"

  assume_role {
    role_arn = "arn:aws:iam::${ module.account_auth.id }:role/OrganizationAccountAccessRole"
  }
}

module "account_auth" {
  source = "../../../modules/aws/account//"

  name  = "auth"
  email = "srlingren+aws-auth@gmail.com"
}

module "account_auth_base" {
  source = "../../../modules/aws/account-base//"

  account_id   = "${ module.account_auth.id }"
  account_name = "${ module.account_auth.name }"

  account_id_auth   = "${ module.account_auth.id }"
  bucket_config_arn = "${ data.terraform_remote_state.account_audit.bucket_config_arn }"

  tags = "${ var.tags }"

  providers {
    aws = "aws.auth"
  }
}

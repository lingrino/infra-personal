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

  auth_account_id = "${ module.account_auth.id }"

  tags = "${ var.tags }"

  providers {
    aws = "aws.auth"
  }
}

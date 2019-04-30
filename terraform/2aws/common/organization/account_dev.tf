provider "aws" {
  alias  = "dev"
  region = "us-east-1"

  assume_role {
    role_arn = "arn:aws:iam::${ module.account_dev.id }:role/OrganizationAccountAccessRole"
  }
}

module "account_dev" {
  source = "../../../modules/aws/account//"

  name  = "dev"
  email = "srlingren+aws-dev@gmail.com"
}

module "account_dev_base" {
  source = "../../../modules/aws/account-base//"

  account_id   = "${ module.account_dev.id }"
  account_name = "${ module.account_dev.name }"

  auth_account_id = "${ module.account_auth.id }"

  tags = "${ var.tags }"

  providers {
    aws = "aws.dev"
  }
}

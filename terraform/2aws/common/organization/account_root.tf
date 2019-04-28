provider "aws" {
  alias  = "root"
  region = "us-east-1"

  assume_role {
    role_arn = "arn:aws:iam::${ module.account_root.id }:role/OrganizationAccountAccessRole"
  }
}

module "account_root" {
  source = "../../../modules/aws/account//"

  name  = "root"
  email = "srlingren+aws-root@gmail.com"
}

module "account_root_base" {
  source = "../../../modules/aws/account-base//"

  account_id   = "${ module.account_root.id }"
  account_name = "${ module.account_root.name }"

  auth_account_id = "${ module.account_auth.id }"

  tags = "${ var.tags }"

  providers {
    aws = "aws.root"
  }
}

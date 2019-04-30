provider "aws" {
  alias  = "audit"
  region = "us-east-1"

  assume_role {
    role_arn = "arn:aws:iam::${ module.account_audit.id }:role/OrganizationAccountAccessRole"
  }
}

module "account_audit" {
  source = "../../../modules/aws/account//"

  name  = "audit"
  email = "srlingren+aws-audit@gmail.com"
}

module "account_audit_base" {
  source = "../../../modules/aws/account-base//"

  account_id   = "${ module.account_audit.id }"
  account_name = "${ module.account_audit.name }"

  auth_account_id = "${ module.account_auth.id }"

  tags = "${ var.tags }"

  providers {
    aws = "aws.audit"
  }
}

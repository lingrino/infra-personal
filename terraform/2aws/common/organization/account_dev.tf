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

  account_id_auth   = "${ module.account_auth.id }"
  bucket_config_arn = "${ data.terraform_remote_state.account_audit.bucket_config_arn }"

  tags = "${ var.tags }"

  providers {
    aws = "aws.dev"
  }
}

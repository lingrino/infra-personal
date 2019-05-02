provider "aws" {
  alias  = "prod"
  region = "us-east-1"

  assume_role {
    role_arn = "arn:aws:iam::${ module.account_prod.id }:role/OrganizationAccountAccessRole"
  }
}

module "account_prod" {
  source = "../../../modules/aws/account//"

  name  = "prod"
  email = "srlingren+aws-prod@gmail.com"
}

module "account_prod_base" {
  source = "../../../modules/aws/account-base//"

  account_id   = "${ module.account_prod.id }"
  account_name = "${ module.account_prod.name }"

  account_id_auth   = "${ module.account_auth.id }"
  bucket_config_arn = "${ data.terraform_remote_state.account_audit.bucket_config_arn }"

  tags = "${ var.tags }"

  providers {
    aws = "aws.prod"
  }
}

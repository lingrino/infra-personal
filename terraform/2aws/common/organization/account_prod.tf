# provider "aws" {
#   alias  = "prod"
#   region = "us-east-1"
#
#   assume_role {
#     role_arn = "arn:aws:iam::${ module.account_prod.id }:role/OrganizationAccountAccessRole"
#   }
# }
#
# module "account_prod" {
#   source = "../../../modules/aws/account//"
#
#   name  = "prod"
#   email = "srlingren+aws-prod@gmail.com"
# }
#
# module "account_prod_base" {
#   source = "../../../modules/aws/account-base//"
#
#   account_id   = "${ module.account_prod.id }"
#   account_name = "${ module.account_prod.name }"
#
#   auth_account_id = "${ module.account_auth.id }"
#
#   tags = "${ var.tags }"
#
#   providers {
#     aws = "aws.prod"
#   }
# }

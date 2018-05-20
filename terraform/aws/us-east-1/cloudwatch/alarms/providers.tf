provider "aws" {
  region              = "${ var.region }"
  allowed_account_ids = ["${ module.constants.aws_account_id }"]
}

provider "aws" {
  region              = "${ module.constants.aws_default_region }"
  allowed_account_ids = ["${ module.constants.aws_account_id }"]
}

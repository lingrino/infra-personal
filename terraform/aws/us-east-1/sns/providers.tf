provider "aws" {
  region              = "us-east-1"
  allowed_account_ids = ["${ module.constants.aws_account_id }"]
}

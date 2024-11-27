data "aws_caller_identity" "s3" {}
data "aws_iam_account_alias" "s3" {}

locals {
  tags = merge({
    terraform = "true"
    module    = "s3"
  }, var.tags)
}

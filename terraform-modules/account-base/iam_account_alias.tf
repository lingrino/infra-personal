resource "aws_iam_account_alias" "alias" {
  account_alias = "lingrino-${ var.account_name }"
}

resource "aws_iam_account_alias" "alias" {
  account_alias = "lingrino-${var.account_name}"
}

output "alias" {
  description = "The alias of the account"
  value       = aws_iam_account_alias.alias.account_alias
}

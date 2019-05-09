output "arn" {
  description = "The arn of the account"
  value       = aws_organizations_account.account.arn
}

output "id" {
  description = "The AWS account ID of the account"
  value       = aws_organizations_account.account.id
}

output "name" {
  description = "The name of the account"
  value       = aws_organizations_account.account.name
}

output "email" {
  description = "The email of the account"
  value       = aws_organizations_account.account.email
}

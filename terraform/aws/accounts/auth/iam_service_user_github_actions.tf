resource "aws_iam_user" "github_actions" {
  name = "github-actions"
  path = "/service/"

  force_destroy = true

  tags = {
    Name = "github-actions"
  }
}

resource "aws_iam_access_key" "github_actions" {
  user   = aws_iam_user.github_actions.name
  status = "Active"
}

output "iam_user_github_actions_akid" {
  description = "The AWS Access Key ID of the github actions user"
  value       = aws_iam_access_key.github_actions.id
}

output "iam_user_github_actions_sak" {
  description = "The AWS Secret Access Key of the github actions user"
  value       = aws_iam_access_key.github_actions.secret
  sensitive   = true
}

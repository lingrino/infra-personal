resource "aws_iam_group_membership" "allow_assume_admin" {
  name  = "allow-assume-admin-members"
  group = aws_iam_group.allow_assume_admin.name

  users = [
    aws_iam_user.sean_lingrino_com.name,
  ]
}

resource "aws_iam_group" "allow_assume_admin" {
  name = "allow-assume-admin"
}

resource "aws_iam_policy_attachment" "allow_assume_admin" {
  name       = "allow-assume-admin-policy-attachments"
  policy_arn = aws_iam_policy.allow_assume_admin.arn
  groups     = [aws_iam_group.allow_assume_admin.name]
}

resource "aws_iam_policy" "allow_assume_admin" {
  name        = "allow-assume-admin"
  description = "Allow the entity to assume the Admin role"
  policy      = data.aws_iam_policy_document.allow_assume_admin.json

  tags = {
    Name = "allow-assume-admin"
  }
}

data "aws_iam_policy_document" "allow_assume_admin" {
  statement {
    sid       = "AllowAssumeAdmin"
    effect    = "Allow"
    actions   = ["sts:AssumeRole", "sts:TagSession"]
    resources = ["arn:aws:iam::*:role/Admin"]
  }
}

resource "aws_iam_group_membership" "allow_assume_read_only" {
  name  = "allow-assume-read-only-members"
  group = aws_iam_group.allow_assume_read_only.name

  users = [
    aws_iam_user.sean_lingrino_com.name,
  ]
}

resource "aws_iam_group" "allow_assume_read_only" {
  name = "allow-assume-read-only"
}

resource "aws_iam_policy_attachment" "allow_assume_read_only" {
  name       = "allow-assume-read-only-policy-attachments"
  policy_arn = aws_iam_policy.allow_assume_read_only.arn
  groups     = [aws_iam_group.allow_assume_read_only.name]
}

resource "aws_iam_policy" "allow_assume_read_only" {
  name        = "allow-assume-read-only"
  description = "Allow the entity to assume the ReadOnly role"
  policy      = data.aws_iam_policy_document.allow_assume_read_only.json

  tags = merge(
    { "Name" = "allow-assume-read-only" },
    { "description" = "Allow the entity to assume the ReadOnly role" },
    var.tags
  )
}

data "aws_iam_policy_document" "allow_assume_read_only" {
  statement {
    sid       = "AllowAssumeReadOnly"
    effect    = "Allow"
    actions   = ["sts:AssumeRole", "sts:TagSession"]
    resources = ["arn:aws:iam::*:role/ReadOnly"]
  }
}

resource "aws_iam_group_membership" "allow_assume_view_only" {
  name  = "allow-assume-view-only-members"
  group = aws_iam_group.allow_assume_view_only.name

  users = [
    aws_iam_user.sean_lingrino_com.name,
  ]
}

resource "aws_iam_group" "allow_assume_view_only" {
  name = "allow-assume-view-only"
}

resource "aws_iam_policy_attachment" "allow_assume_view_only" {
  name       = "allow-assume-view-only-policy-attachments"
  policy_arn = aws_iam_policy.allow_assume_view_only.arn
  groups     = [aws_iam_group.allow_assume_view_only.name]
}

resource "aws_iam_policy" "allow_assume_view_only" {
  name        = "allow-assume-view-only"
  description = "Allow the entity to assume the ViewOnly role"
  policy      = data.aws_iam_policy_document.allow_assume_view_only.json
}

data "aws_iam_policy_document" "allow_assume_view_only" {
  statement {
    sid       = "AllowAssumeViewOnly"
    effect    = "Allow"
    actions   = ["sts:AssumeRole", "sts:TagSession"]
    resources = ["arn:aws:iam::*:role/ViewOnly"]
  }
}

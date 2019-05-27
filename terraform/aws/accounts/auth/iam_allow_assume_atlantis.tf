resource "aws_iam_group_membership" "allow_assume_atlantis" {
  name  = "allow-assume-atlantis-members"
  group = aws_iam_group.allow_assume_atlantis.name

  users = [
    aws_iam_user.atlantis.name,
  ]
}

resource "aws_iam_group" "allow_assume_atlantis" {
  name = "allow-assume-atlantis"
}

resource "aws_iam_policy_attachment" "allow_assume_atlantis" {
  name       = "allow-assume-atlantis-policy-attachments"
  policy_arn = aws_iam_policy.allow_assume_atlantis.arn
  groups     = [aws_iam_group.allow_assume_atlantis.name]
}

resource "aws_iam_policy" "allow_assume_atlantis" {
  name        = "allow-assume-atlantis"
  description = "Allow the entity to assume the atlantis role"
  policy      = data.aws_iam_policy_document.allow_assume_atlantis.json
}

data "aws_iam_policy_document" "allow_assume_atlantis" {
  statement {
    sid       = "AllowAssumeAtlantis"
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = ["arn:aws:iam::*:role/atlantis"]
  }
}

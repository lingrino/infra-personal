resource "aws_iam_role" "atlantis" {
  name               = "atlantis"
  description        = "The role assumed by the atlantis user to plan and apply"
  assume_role_policy = data.aws_iam_policy_document.arp_users.json

  max_session_duration = 7200

  tags = merge(
    { "Name" = "atlantis" },
    { "description" = "The role assumed by the atlantis user to plan and apply" },
    var.tags
  )
}

resource "aws_iam_role_policy_attachment" "atlantis_administrator" {
  role       = aws_iam_role.atlantis.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

data "aws_iam_policy_document" "arp_atlantis" {
  statement {
    sid = "AuthAccountAssumeRole"

    principals {
      type        = "AWS"
      identifiers = [var.account_id_auth]
    }

    actions = ["sts:AssumeRole"]

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["true"]
    }
  }
}

data "aws_iam_policy_document" "arp_user" {
  statement {
    sid = "AuthAccountAssumeRoleRequireMFA"

    principals {
      type        = "AWS"
      identifiers = [var.account_id_auth]
    }

    actions = [
      "sts:AssumeRole",
      "sts:TagSession",
    ]

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["true"]
    }

    condition {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["true"]
    }
  }
}

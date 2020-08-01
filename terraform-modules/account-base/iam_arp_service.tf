data "aws_iam_policy_document" "arp_service" {
  statement {
    sid = "AuthAccountAssumeRole"

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
  }
}

data "aws_iam_policy_document" "arp_users" {
  statement {
    sid = "AuthAccountAssumeRoleRequireMFA"

    principals {
      type        = "AWS"
      identifiers = ["${ var.auth_account_id }"]
    }

    actions = ["sts:AssumeRole"]

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

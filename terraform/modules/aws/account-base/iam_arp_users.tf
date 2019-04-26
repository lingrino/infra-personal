data "aws_iam_policy_document" "arp_users" {
  statement {
    sid = "MainAccountAssumeRoleRequireMFA"

    # TODO - restrict this to a group or other identifier
    principals {
      type        = "AWS"
      identifiers = ["${ var.main_account_id }"]
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

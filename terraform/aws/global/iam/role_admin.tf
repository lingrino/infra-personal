resource "aws_iam_role" "admin" {
  name               = "admin"
  description        = "The admin role (all permissions) to be assumed by users"
  assume_role_policy = "${ data.aws_iam_policy_document.role_admin_assume_role_policy.json }"

  max_session_duration  = "43200" # 12 hours in seconds
  force_detach_policies = true
}

resource "aws_iam_policy_attachment" "administrator_policy_attachments" {
  name       = "administrator_policy_attachments"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  roles      = ["${ aws_iam_role.admin.name }"]
}

data "aws_iam_policy_document" "role_admin_assume_role_policy" {
  statement {
    sid = "AllowAssumeFromAccountWithMFA"

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${ module.constants.aws_account_id }:root"]
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

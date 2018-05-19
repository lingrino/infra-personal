resource "aws_kms_key" "terraform_remote_state" {
  description = "KMS key for encrypting terraform remote state in S3"

  is_enabled              = true
  enable_key_rotation     = true
  deletion_window_in_days = 30

  policy = "${ data.aws_iam_policy_document.terraform_remote_state_policy.json }"

  tags = "${ merge(
    map(
      "Name",
      "kms_key_s3_terraform_remote_state"
    ),
    module.constants.tags_default )
  }"
}

resource "aws_kms_alias" "terraform_remote_state_alias" {
  name          = "alias/s3_terraform_remote_state"
  target_key_id = "${ aws_kms_key.terraform_remote_state.key_id }"
}

data "aws_iam_policy_document" "terraform_remote_state_policy" {
  statement {
    sid    = "AllowRootUserStar"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${ module.constants.aws_account_id }:root"]
    }

    actions = [
      "kms:*",
    ]

    resources = ["*"]
  }

  statement {
    sid    = "AllowAdministrationByAdmins"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["${ data.terraform_remote_state.iam.role_admin_arn }"]
    }

    actions = [
      "kms:Create*",
      "kms:Describe*",
      "kms:Enable*",
      "kms:List*",
      "kms:Put*",
      "kms:Update*",
      "kms:Revoke*",
      "kms:Disable*",
      "kms:Get*",
      "kms:Delete*",
      "kms:TagResource",
      "kms:UntagResource",
      "kms:ScheduleKeyDeletion",
      "kms:CancelKeyDeletion",
    ]

    resources = ["*"]
  }

  statement {
    sid    = "AllowUseByUsers"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["${ data.terraform_remote_state.iam.role_admin_arn }"]
    }

    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey",
    ]

    resources = ["*"]
  }

  statement {
    sid    = "AllowAttachmentByUsers"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["${ data.terraform_remote_state.iam.role_admin_arn }"]
    }

    actions = [
      "kms:CreateGrant",
      "kms:ListGrants",
      "kms:RevokeGrant",
    ]

    resources = ["*"]

    condition {
      test     = "Bool"
      variable = "kms:GrantIsForAWSResource"
      values   = ["true"]
    }
  }
}

resource "aws_kms_key" "main" {
  description = "KMS key for encrypting objects not otherwise encrypted by a more specific key"

  is_enabled              = true
  enable_key_rotation     = true
  deletion_window_in_days = 30

  policy = "${ data.aws_iam_policy_document.main_policy.json }"

  tags = "${ merge(
    map(
      "Name",
      "kms_key_main"
    ),
    module.constants.tags_default )
  }"
}

resource "aws_kms_alias" "main_alias" {
  name          = "alias/main"
  target_key_id = "${ aws_kms_key.main.key_id }"
}

data "aws_iam_policy_document" "main_policy" {
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

  statement {
    sid    = "AllowSESEncryption"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ses.amazonaws.com"]
    }

    actions = [
      "kms:Encrypt",
      "kms:GenerateDataKey*",
    ]

    resources = ["*"]

    condition {
      test     = "Null"
      variable = "kms:EncryptionContext:aws:ses:rule-name"
      values   = ["false"]
    }

    condition {
      test     = "Null"
      variable = "kms:EncryptionContext:aws:ses:message-id"
      values   = ["false"]
    }

    condition {
      test     = "StringEquals"
      variable = "kms:EncryptionContext:aws:ses:source-account"
      values   = ["${ module.constants.aws_account_id }"]
    }
  }
}

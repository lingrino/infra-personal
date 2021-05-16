resource "aws_kms_alias" "cloudtrail" {
  name          = "alias/cloudtrail"
  target_key_id = aws_kms_key.cloudtrail.key_id
}

resource "aws_kms_key" "cloudtrail" {
  is_enabled  = true
  description = "A key to encrypt all cloudtrail data"

  policy = data.aws_iam_policy_document.kms_policy_cloudtrail.json

  enable_key_rotation     = true
  deletion_window_in_days = 30

  tags = {
    Name        = "cloudtrail"
    description = "A key to encrypt all cloudtrail data"
    service     = "kms"
  }
}

data "aws_iam_policy_document" "kms_policy_cloudtrail" {
  statement {
    sid    = "AllowAuditAdminManage"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.account_id_audit}:root"]
    }

    actions = ["kms:*"]

    resources = ["*"]
  }

  statement {
    sid    = "AllowCloudTrailDecryptForSpecificRoles"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.account_id_audit}:role/Admin"]
    }

    actions = ["kms:Decrypt"]

    resources = ["*"]

    condition {
      test     = "Null"
      variable = "kms:EncryptionContext:aws:cloudtrail:arn"
      values   = [false]
    }
  }

  statement {
    sid    = "AllowCloudTrailDescribe"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions = ["kms:DescribeKey"]

    resources = ["*"]
  }

  statement {
    sid    = "AllowCloudTrailEncrypt"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions = ["kms:GenerateDataKey*"]

    resources = ["*"]

    condition {
      test     = "StringLike"
      variable = "kms:EncryptionContext:aws:cloudtrail:arn"
      values   = formatlist("arn:aws:cloudtrail:*:%s:trail/*", data.terraform_remote_state.organization.outputs.account_ids)
    }
  }
}

output "kms_key_cloudtrail_arn" {
  description = "The ARN of the kms key that cloudtrail should use to encrypt"
  value       = aws_kms_key.cloudtrail.arn
}

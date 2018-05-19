locals {
  remote_state_bucket_name = "terraform-remote-state"
}

resource "aws_s3_bucket" "bucket_terraform_remote_state" {
  bucket_prefix = "${ local.remote_state_bucket_name }-"
  region        = "${ module.constants.aws_default_region }"
  acl           = "private"
  force_destroy = true

  versioning {
    enabled = true
  }

  logging {
    target_bucket = "${ aws_s3_bucket.bucket_logs.id }"
    target_prefix = "s3/${ local.remote_state_bucket_name }/access-logs/"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = "${ data.terraform_remote_state.kms_us_east_2.key_terraform_remote_state_arn }"
        sse_algorithm     = "aws:kms"
      }
    }
  }

  lifecycle_rule {
    id                                     = "${ local.remote_state_bucket_name }-state-lifecycle"
    enabled                                = true
    abort_incomplete_multipart_upload_days = 1

    noncurrent_version_transition {
      days          = "30"
      storage_class = "GLACIER"
    }

    noncurrent_version_expiration {
      days = "300"
    }
  }

  tags = "${ merge(
    map(
      "Name",
      "${ local.remote_state_bucket_name }"
    ),
    module.constants.tags_default )
  }"
}

resource "aws_s3_bucket_policy" "bucket_terraform_remote_state_policy" {
  bucket = "${ aws_s3_bucket.bucket_terraform_remote_state.id }"
  policy = "${ data.aws_iam_policy_document.bucket_terraform_remote_state_policy_data.json }"
}

data "aws_iam_policy_document" "bucket_terraform_remote_state_policy_data" {
  statement {
    sid    = "DenyIncorrectEncryptionHeader"
    effect = "Deny"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:PutObject",
    ]

    resources = ["${ aws_s3_bucket.bucket_terraform_remote_state.arn }/*"]

    condition {
      test     = "StringNotEquals"
      variable = "s3:x-amz-server-side-encryption"
      values   = ["aws:kms"]
    }
  }

  statement {
    sid    = "DenyUnEncryptedObjectUploads"
    effect = "Deny"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:PutObject",
    ]

    resources = ["${ aws_s3_bucket.bucket_terraform_remote_state.arn }/*"]

    condition {
      test     = "Null"
      variable = "s3:x-amz-server-side-encryption"
      values   = ["true"]
    }
  }
}

locals {
  logs_bucket_name = "logs"
}

resource "aws_s3_bucket" "bucket_logs" {
  bucket_prefix = "${ local.logs_bucket_name }-"

  region        = "${ module.constants.aws_default_region }"
  acl           = "log-delivery-write"
  force_destroy = true

  lifecycle_rule {
    id      = "all-logs-lifecycle"
    prefix  = "/"
    enabled = true

    abort_incomplete_multipart_upload_days = 1

    transition {
      days          = "30"
      storage_class = "GLACIER"
    }

    expiration {
      days = "300"
    }
  }

  tags = "${ merge(
    map(
      "Name",
      "${ local.logs_bucket_name }"
    ),
    module.constants.tags_default )
  }"
}

resource "aws_s3_bucket_policy" "bucket_logs_policy" {
  bucket = "${ aws_s3_bucket.bucket_logs.id }"
  policy = "${ data.aws_iam_policy_document.bucket_logs_policy_data.json }"
}

data "aws_iam_policy_document" "bucket_logs_policy_data" {
  statement {
    sid    = "AWSCloudTrailAclCheck"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions = [
      "s3:GetBucketAcl",
    ]

    resources = ["${ aws_s3_bucket.bucket_logs.arn }"]
  }

  statement {
    sid    = "AWSCloudTrailWrite"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions = [
      "s3:PutObject",
    ]

    resources = ["${ aws_s3_bucket.bucket_logs.arn }/cloudtrail/*"]

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }
}

resource "aws_s3_bucket" "cloudtrail" {
  bucket_prefix = "cloudtrail-"
  acl           = "log-delivery-write"
  force_destroy = false

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  lifecycle_rule {
    id                                     = "all-cloudtrail-lifecycle"
    enabled                                = true
    abort_incomplete_multipart_upload_days = 1

    expiration {
      days = "365"
    }

    noncurrent_version_expiration {
      days = "365"
    }
  }

  tags = merge(
    { "Name" = "cloudtrail" },
    { "description" = "Stores all AWS cloudtrail logs" },
    { "service" = "cloudtrail" },
    var.tags
  )
}

resource "aws_s3_bucket_policy" "cloudtrail" {
  bucket = aws_s3_bucket.cloudtrail.id
  policy = data.aws_iam_policy_document.bucket_policy_cloudtrail.json
}

data "aws_iam_policy_document" "bucket_policy_cloudtrail" {
  statement {
    sid    = "AWSCloudTrailAclCheck"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions   = ["s3:GetBucketAcl"]
    resources = [aws_s3_bucket.cloudtrail.arn]
  }

  statement {
    sid    = "AWSCloudTrailWrite"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions = ["s3:PutObject"]

    resources = ["${aws_s3_bucket.cloudtrail.arn}/*"]

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }

  statement {
    sid    = "DenyInsecureUsage"
    effect = "Deny"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = ["*"]

    resources = ["${aws_s3_bucket.cloudtrail.arn}/*"]

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
  }
}

output "bucket_cloudtrail_arn" {
  description = "The ARN of the cloudtrail bucket"
  value       = aws_s3_bucket.cloudtrail.arn
}

output "bucket_cloudtrail_name" {
  description = "The name of the cloudtrail bucket"
  value       = aws_s3_bucket.cloudtrail.id
}

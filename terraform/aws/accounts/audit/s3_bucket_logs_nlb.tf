resource "aws_s3_bucket" "logs_nlb" {
  bucket_prefix = "logs-nlb-"
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
    id                                     = "all-logs-nlb-lifecycle"
    enabled                                = true
    abort_incomplete_multipart_upload_days = 1

    transition {
      days          = "90"
      storage_class = "GLACIER"
    }

    noncurrent_version_transition {
      days          = "90"
      storage_class = "GLACIER"
    }

    expiration {
      days = "365"
    }

    noncurrent_version_expiration {
      days = "365"
    }
  }

  tags = merge(
    {"Name" = "logs-nlb"},
    {"description" = "Stores all of our network load balancer access logs"},
    {"service" = "logs-nlb"},
    var.tags,
  )
}

resource "aws_s3_bucket_policy" "logs_nlb" {
  bucket = aws_s3_bucket.logs_nlb.id
  policy = data.aws_iam_policy_document.bucket_policy_logs_nlb.json
}

# https://docs.aws.amazon.com/elasticloadbalancing/latest/network/load-balancer-access-logs.html
data "aws_iam_policy_document" "bucket_policy_logs_nlb" {
  statement {
    sid    = "AWSLogDeliveryAclCheck"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }

    actions = ["s3:GetBucketAcl"]

    resources = [aws_s3_bucket.logs_nlb.arn]
  }

  statement {
    sid    = "AWSLogDeliveryWrite"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }

    actions = ["s3:PutObject"]

    resources = ["${aws_s3_bucket.logs_nlb.arn}/*"]

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }
}

output "bucket_logs_nlb_arn" {
  description = "The ARN of the logs nlb bucket"
  value       = aws_s3_bucket.logs_nlb.arn
}

output "bucket_logs_nlb_name" {
  description = "The name of the logs nlb bucket"
  value       = aws_s3_bucket.logs_nlb.id
}

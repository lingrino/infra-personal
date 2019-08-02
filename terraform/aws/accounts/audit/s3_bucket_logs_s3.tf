resource "aws_s3_bucket" "logs_s3" {
  bucket_prefix = "logs-s3-"
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
    id                                     = "all-logs-s3-lifecycle"
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
    { "Name" = "logs-s3" },
    { "description" = "Stores all of our s3 access logs" },
    { "service" = "logs-s3" },
    var.tags
  )
}

resource "aws_s3_bucket_policy" "logs_s3" {
  bucket = aws_s3_bucket.logs_s3.id
  policy = data.aws_iam_policy_document.bucket_policy_logs_s3.json
}

# https://docs.aws.amazon.com/elasticloadbalancing/latest/network/load-balancer-access-logs.html
data "aws_iam_policy_document" "bucket_policy_logs_s3" {
  statement {
    sid    = "DenyInsecureUsage"
    effect = "Deny"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = ["*"]

    resources = ["${aws_s3_bucket.serverless_deployment.arn}/*"]

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
  }
}

output "bucket_logs_s3_arn" {
  description = "The ARN of the logs s3 bucket"
  value       = aws_s3_bucket.logs_s3.arn
}

output "bucket_logs_s3_name" {
  description = "The name of the logs s3 bucket"
  value       = aws_s3_bucket.logs_s3.id
}

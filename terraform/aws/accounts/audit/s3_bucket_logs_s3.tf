resource "aws_s3_bucket" "logs_s3" {
  bucket_prefix = "logs-s3-"
  force_destroy = false

  tags = {
    Name        = "logs-s3"
    description = "Stores all of our s3 access logs"
    service     = "logs-s3"
  }
}

resource "aws_s3_bucket_acl" "logs_s3" {
  bucket = aws_s3_bucket.logs_s3.id
  acl    = "log-delivery-write"
}

resource "aws_s3_bucket_versioning" "logs_s3" {
  bucket = aws_s3_bucket.logs_s3.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "logs_s3" {
  bucket = aws_s3_bucket.logs_s3.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "logs_s3" {
  bucket = aws_s3_bucket.logs_s3.bucket

  rule {
    id     = "all-logs-s3-lifecycle"
    status = "Enabled"

    abort_incomplete_multipart_upload {
      days_after_initiation = 1
    }

    transition {
      days          = 90
      storage_class = "GLACIER"
    }

    noncurrent_version_transition {
      noncurrent_days = 90
      storage_class   = "GLACIER"
    }

    expiration {
      days = 365
    }

    noncurrent_version_expiration {
      noncurrent_days = 365
    }
  }
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

    resources = ["${aws_s3_bucket.logs_s3.arn}/*"]

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

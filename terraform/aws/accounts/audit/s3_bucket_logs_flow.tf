resource "aws_s3_bucket" "logs_flow" {
  bucket_prefix = "logs-flow-"
  force_destroy = false

  tags = {
    Name        = "logs-flow"
    description = "Stores all of our VPC and other flow logs"
    service     = "logs-flow"
  }
}

resource "aws_s3_bucket_acl" "logs_flow" {
  bucket = aws_s3_bucket.logs_flow.id
  acl    = "log-delivery-write"
}

resource "aws_s3_bucket_versioning" "logs_flow" {
  bucket = aws_s3_bucket.logs_flow.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "logs_flow" {
  bucket = aws_s3_bucket.logs_flow.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "logs_flow" {
  bucket = aws_s3_bucket.logs_flow.bucket

  rule {
    id     = "all-logs-flow-lifecycle"
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

resource "aws_s3_bucket_policy" "logs_flow" {
  bucket = aws_s3_bucket.logs_flow.id
  policy = data.aws_iam_policy_document.bucket_policy_logs_flow.json
}

# https://docs.aws.amazon.com/elasticloadbalancing/latest/network/load-balancer-access-logs.html
data "aws_iam_policy_document" "bucket_policy_logs_flow" {
  statement {
    sid    = "AWSLogDeliveryAclCheck"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }

    actions = ["s3:GetBucketAcl"]

    resources = [aws_s3_bucket.logs_flow.arn]
  }

  statement {
    sid    = "AWSLogDeliveryWrite"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }

    actions = ["s3:PutObject"]

    resources = ["${aws_s3_bucket.logs_flow.arn}/*"]

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

    resources = ["${aws_s3_bucket.logs_flow.arn}/*"]

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
  }
}

output "bucket_logs_flow_arn" {
  description = "The ARN of the logs flow bucket"
  value       = aws_s3_bucket.logs_flow.arn
}

output "bucket_logs_flow_name" {
  description = "The name of the logs flow bucket"
  value       = aws_s3_bucket.logs_flow.id
}

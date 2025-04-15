# create the bucket
resource "aws_s3_bucket" "s3" {
  bucket = var.name

  tags = merge(local.tags, {
    Name = var.name
  })
}

# block all public access
resource "aws_s3_bucket_public_access_block" "s3" {
  bucket = aws_s3_bucket.s3.bucket

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = false
}

# turn off acls
resource "aws_s3_bucket_ownership_controls" "s3" {
  bucket = aws_s3_bucket.s3.bucket

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# enforce object encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "s3" {
  bucket                = aws_s3_bucket.s3.bucket
  expected_bucket_owner = data.aws_caller_identity.s3.account_id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# enable transfer acceleration
resource "aws_s3_bucket_accelerate_configuration" "s3" {
  bucket                = aws_s3_bucket.s3.bucket
  expected_bucket_owner = data.aws_caller_identity.s3.account_id
  status                = "Enabled"
}

# enable bucket metrics
resource "aws_s3_bucket_metric" "s3" {
  count = var.enable_request_metrics ? 1 : 0

  bucket = aws_s3_bucket.s3.bucket
  name   = "root"
}

# enable access logging
resource "aws_s3_bucket_logging" "s3" {
  count = var.enable_logging ? 1 : 0

  bucket                = aws_s3_bucket.s3.bucket
  expected_bucket_owner = data.aws_caller_identity.s3.account_id

  target_bucket = "${data.aws_iam_account_alias.s3.id}-usw2-s3-logs"
  target_prefix = ""

  target_object_key_format {
    partitioned_prefix {
      partition_date_source = "EventTime"
    }
  }
}

# enable versioning
resource "aws_s3_bucket_versioning" "s3" {
  bucket                = aws_s3_bucket.s3.bucket
  expected_bucket_owner = data.aws_caller_identity.s3.account_id

  versioning_configuration {
    status = var.enable_versioning ? "Enabled" : "Suspended"
  }
}

# enable object lock
resource "aws_s3_bucket_object_lock_configuration" "s3" {
  count = var.enable_object_lock ? 1 : 0

  bucket                = aws_s3_bucket_versioning.s3.bucket
  expected_bucket_owner = data.aws_caller_identity.s3.account_id

  rule {
    default_retention {
      mode  = "GOVERNANCE"
      years = 3
    }
  }
}

# enable lifecycle rules
resource "aws_s3_bucket_lifecycle_configuration" "s3" {
  bucket = aws_s3_bucket.s3.bucket

  # abort multipart uploads after 1 day
  rule {
    id     = "abort-incomplete-uploads"
    status = "Enabled"

    abort_incomplete_multipart_upload {
      days_after_initiation = 1
    }
  }

  # move all objects to intelligent tiering
  dynamic "rule" {
    for_each = var.enable_intelligent_tiering ? [1] : []

    content {
      id     = "enable-intelligent-tiering"
      status = "Enabled"

      transition {
        days          = 0
        storage_class = "INTELLIGENT_TIERING"
      }
      noncurrent_version_transition {
        noncurrent_days = 0
        storage_class   = "INTELLIGENT_TIERING"
      }
    }
  }

  # delete noncurrent versions after variable days
  dynamic "rule" {
    for_each = var.versioning_retention_days >= 0 ? [1] : []

    content {
      id     = "expire-noncurrent-versions"
      status = "Enabled"

      noncurrent_version_expiration {
        noncurrent_days = var.versioning_retention_days
      }
    }
  }
}

# attach bucket policy
resource "aws_s3_bucket_policy" "s3" {
  bucket = aws_s3_bucket.s3.bucket
  policy = data.aws_iam_policy_document.s3.json
}

# replace ___ARN___ in bucket policy with bucket arn
locals {
  policy = replace(var.policy, "___ARN___", aws_s3_bucket.s3.arn)
}

# default bucket policy
data "aws_iam_policy_document" "s3" {
  source_policy_documents = [
    local.policy,
    data.aws_iam_policy_document.cf.json,
  ]

  statement {
    sid    = "EnforceSecureTransport"
    effect = "Deny"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = ["*"]

    resources = [
      aws_s3_bucket.s3.arn,
      "${aws_s3_bucket.s3.arn}/*",
    ]

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
  }
}

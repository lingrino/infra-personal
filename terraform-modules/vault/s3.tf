resource "aws_s3_bucket_public_access_block" "config" {
  bucket = aws_s3_bucket.config.id

  ignore_public_acls      = true
  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "config" {
  bucket = aws_s3_bucket.config.id
  policy = data.aws_iam_policy_document.s3_config.json
}

resource "aws_s3_bucket" "config" {
  bucket_prefix = "${var.name_prefix}-config-"
  region        = data.aws_region.current.name
  force_destroy = true

  acl = "private"

  versioning {
    enabled = true
  }

  logging {
    target_bucket = aws_s3_bucket.logs.id
    target_prefix = "s3-access-logs/config/"
  }

  lifecycle_rule {
    id      = "config"
    enabled = true
    prefix  = ""

    abort_incomplete_multipart_upload_days = 7

    noncurrent_version_expiration {
      days = "30"
    }
  }

  tags = merge(
    { "Name" = "${var.name_prefix}-config" },
    var.tags,
  )
}

resource "aws_s3_bucket_public_access_block" "logs" {
  bucket = aws_s3_bucket.logs.id

  ignore_public_acls      = true
  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "logs" {
  bucket = aws_s3_bucket.logs.id
  policy = data.aws_iam_policy_document.s3_logs.json
}

resource "aws_s3_bucket" "logs" {
  bucket_prefix = "${var.name_prefix}-logs-"
  region        = data.aws_region.current.name
  force_destroy = true

  acl = "log-delivery-write"

  lifecycle_rule {
    id      = "logs"
    enabled = true

    abort_incomplete_multipart_upload_days = 7

    transition {
      days          = "30"
      storage_class = "GLACIER"
    }

    expiration {
      days = "365"
    }
  }

  tags = merge(
    { "Name" = "${var.name_prefix}-logs" },
    var.tags,
  )
}

resource "aws_s3_bucket_public_access_block" "state" {
  bucket = aws_s3_bucket.state.id

  ignore_public_acls      = true
  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket" "state" {
  bucket_prefix = "${var.name_prefix}-"
  acl           = "private"
  force_destroy = false

  versioning {
    enabled = true
  }

  logging {
    target_bucket = aws_s3_bucket.logs.id
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  lifecycle_rule {
    id                                     = "${var.name_prefix}-lifecycle"
    enabled                                = true
    abort_incomplete_multipart_upload_days = 1

    noncurrent_version_transition {
      days          = "30"
      storage_class = "GLACIER"
    }
  }

  tags = merge(
    {"Name" = var.name_prefix},
    var.tags,
  )
}

resource "aws_s3_bucket_policy" "state" {
  bucket = aws_s3_bucket.state.id
  policy = data.aws_iam_policy_document.state.json
}

resource "aws_s3_bucket_public_access_block" "wg" {
  bucket = aws_s3_bucket.wg.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

data "template_file" "wg0_conf" {
  template = file("${path.module}/files/wg0.conf.j2")

  vars = {
    wg_address = var.wg_address
    wg_port    = var.wg_port
  }
}

resource "aws_s3_bucket_object" "wg0_conf" {
  bucket  = aws_s3_bucket.wg.id
  key     = "wg0.conf"
  content = data.template_file.wg0_conf.rendered
  etag    = md5(data.template_file.wg0_conf.rendered)
}

resource "aws_s3_bucket" "wg" {
  bucket_prefix = "${var.name_prefix}-"
  force_destroy = true

  acl = "private"

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

  tags = merge(
    { "Name" = var.name_prefix },
    var.tags,
  )
}

resource "aws_s3_bucket_policy" "wg" {
  bucket = aws_s3_bucket.wg.id
  policy = data.aws_iam_policy_document.wg_s3.json
}

data "aws_iam_policy_document" "wg_s3" {
  statement {
    sid    = "DenyInsecureConnections"
    effect = "Deny"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:*",
    ]

    resources = [aws_s3_bucket.wg.arn]

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"

      values = ["false"]
    }
  }

  statement {
    sid    = "DenyNotBucketOwnerFullControl"
    effect = "Deny"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:PutObject",
    ]

    resources = ["${aws_s3_bucket.wg.arn}/*"]

    condition {
      test     = "StringNotEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }

  statement {
    sid    = "DenyUnencryptedObjectUploads"
    effect = "Deny"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:PutObject",
    ]

    resources = ["${aws_s3_bucket.wg.arn}/*"]

    condition {
      test     = "Null"
      variable = "s3:x-amz-server-side-encryption"
      values   = ["true"]
    }
  }

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

    resources = ["${aws_s3_bucket.wg.arn}/*"]

    condition {
      test     = "StringNotEquals"
      variable = "s3:x-amz-server-side-encryption"
      values   = ["AES256"]
    }
  }
}

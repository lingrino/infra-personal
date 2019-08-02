resource "aws_s3_bucket" "logs_clb" {
  bucket_prefix = "logs-clb-"
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
    id                                     = "all-logs-clb-lifecycle"
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
    { "Name" = "logs-clb" },
    { "description" = "Stores all of our classic load balancer access logs" },
    { "service" = "logs-clb" },
    var.tags
  )
}

resource "aws_s3_bucket_policy" "logs_clb" {
  bucket = aws_s3_bucket.logs_clb.id
  policy = data.aws_iam_policy_document.bucket_policy_logs_clb.json
}

# https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/enable-access-logs.html
data "aws_iam_policy_document" "bucket_policy_logs_clb" {
  statement {
    sid    = "AWSCLBAccountsWrite"
    effect = "Allow"

    principals {
      type = "AWS"

      identifiers = [
        "arn:aws:iam::127311923021:root",
        "arn:aws:iam::033677994240:root",
        "arn:aws:iam::027434742980:root",
        "arn:aws:iam::797873946194:root",
        "arn:aws:iam::985666609251:root",
        "arn:aws:iam::054676820928:root",
        "arn:aws:iam::156460612806:root",
        "arn:aws:iam::652711504416:root",
        "arn:aws:iam::009996457667:root",
        "arn:aws:iam::897822967062:root",
        "arn:aws:iam::754344448648:root",
        "arn:aws:iam::582318560864:root",
        "arn:aws:iam::600734575887:root",
        "arn:aws:iam::383597477331:root",
        "arn:aws:iam::114774131450:root",
        "arn:aws:iam::783225319266:root",
        "arn:aws:iam::718504428378:root",
        "arn:aws:iam::507241528517:root",
      ]
    }

    actions = ["s3:PutObject"]

    resources = ["${aws_s3_bucket.logs_clb.arn}/*"]

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

    resources = ["${aws_s3_bucket.logs_clb.arn}/*"]

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
  }
}

output "bucket_logs_clb_arn" {
  description = "The ARN of the logs clb bucket"
  value       = aws_s3_bucket.logs_clb.arn
}

output "bucket_logs_clb_name" {
  description = "The name of the logs clb bucket"
  value       = aws_s3_bucket.logs_clb.id
}

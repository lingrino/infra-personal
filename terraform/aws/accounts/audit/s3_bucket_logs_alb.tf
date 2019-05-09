resource "aws_s3_bucket" "logs_alb" {
  bucket_prefix = "logs-alb-"
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
    id                                     = "all-logs-alb-lifecycle"
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
    {"Name" = "logs-alb"},
    {"description" = "Stores all of our application load balancer access logs"},
    {"service" = "logs-alb"},
    var.tags
  )
}

resource "aws_s3_bucket_policy" "logs_alb" {
  bucket = aws_s3_bucket.logs_alb.id
  policy = data.aws_iam_policy_document.bucket_policy_logs_alb.json
}

# https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-access-logs.html
data "aws_iam_policy_document" "bucket_policy_logs_alb" {
  statement {
    sid    = "AWSALBAccountsWrite"
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

    resources = ["${aws_s3_bucket.logs_alb.arn}/*"]

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }
}

output "bucket_logs_alb_arn" {
  description = "The ARN of the logs alb bucket"
  value       = aws_s3_bucket.logs_alb.arn
}

output "bucket_logs_alb_name" {
  description = "The name of the logs alb bucket"
  value       = aws_s3_bucket.logs_alb.id
}

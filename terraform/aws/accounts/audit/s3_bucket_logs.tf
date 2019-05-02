resource "aws_s3_bucket" "logs" {
  bucket_prefix = "logs-"
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
    id                                     = "all-logs-lifecycle"
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

  tags = "${ merge(
    map("Name", "logs"),
    map("description", "Stores all of our generic AWS logs that do not fit anywhere else"),
    map("service", "logs"),
    var.tags )
  }"
}

output "bucket_logs_arn" {
  description = "The ARN of the logs bucket"
  value       = "${ aws_s3_bucket.logs.arn }"
}

output "bucket_logs_name" {
  description = "The name of the logs bucket"
  value       = "${ aws_s3_bucket.logs.id }"
}

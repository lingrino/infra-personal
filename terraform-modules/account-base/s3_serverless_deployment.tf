resource "aws_s3_bucket" "serverless_deployment" {
  bucket_prefix = "serverless-deployment-"
  acl           = "private"
  force_destroy = true

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

  tags = "${ merge(
    map("Name", "serverless-deployment"),
    map("description", "A bucket to store all serverless deployments in our account"),
    map("service", "serverless"),
    var.tags
  )}"
}

resource "aws_s3_bucket_policy" "serverless_deployment" {
  bucket = "${ aws_s3_bucket.serverless_deployment.id }"
  policy = "${ data.aws_iam_policy_document.bucket_policy_serverless_deployment.json }"
}

data "aws_iam_policy_document" "bucket_policy_serverless_deployment" {
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

    resources = ["${ aws_s3_bucket.serverless_deployment.arn }/*"]

    condition {
      test     = "StringNotEquals"
      variable = "s3:x-amz-server-side-encryption"
      values   = ["AES256"]
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

    resources = ["${ aws_s3_bucket.serverless_deployment.arn }/*"]

    condition {
      test     = "Null"
      variable = "s3:x-amz-server-side-encryption"
      values   = ["true"]
    }
  }
}

output "bucket_serverless_deployment_arn" {
  description = "The ARN of the serverless-deployment bucket"
  value       = "${ aws_s3_bucket.serverless_deployment.arn }"
}

output "bucket_serverless_deployment_name" {
  description = "The name of the serverless-deployment bucket"
  value       = "${ aws_s3_bucket.serverless_deployment.id }"
}

# We write the name and ARN of the S3 serverless-deployment bucket to SSM
# so that it can easily be read by a serverless.yml
resource "aws_ssm_parameter" "s3_serverless_deployment_arn" {
  name        = "/s3/serverless-deployment/arn"
  description = "The ARN of the S3 serverless deployment bucket"
  type        = "String"
  value       = aws_s3_bucket.serverless_deployment.arn

  tags = merge(
    {"Name" = "/s3/serverless-deployment/arn"},
    {"description" = "The ARN of the S3 serverless deployment bucket"},
    var.tags
  )
}

resource "aws_ssm_parameter" "s3_serverless_deployment_name" {
  name        = "/s3/serverless-deployment/name"
  description = "The name of the S3 serverless deployment bucket"
  type        = "String"
  value       = aws_s3_bucket.serverless_deployment.id

  tags = merge(
    {"Name" = "/s3/serverless-deployment/name"},
    {"description" = "The name of the S3 serverless deployment bucket"},
    var.tags
  )
}

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

  tags = merge(
    {"Name" = "serverless-deployment"},
    {"description" = "A bucket to store all serverless deployments in our account"},
    {"service" = "serverless"},
    var.tags
  )
}

resource "aws_s3_bucket_policy" "serverless_deployment" {
  bucket = aws_s3_bucket.serverless_deployment.id
  policy = data.aws_iam_policy_document.bucket_policy_serverless_deployment.json
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

    resources = ["${aws_s3_bucket.serverless_deployment.arn}/*"]

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

    resources = ["${aws_s3_bucket.serverless_deployment.arn}/*"]

    condition {
      test     = "Null"
      variable = "s3:x-amz-server-side-encryption"
      values   = ["true"]
    }
  }
}

output "bucket_serverless_deployment_arn" {
  description = "The ARN of the serverless-deployment bucket"
  value       = aws_s3_bucket.serverless_deployment.arn
}

output "bucket_serverless_deployment_name" {
  description = "The name of the serverless-deployment bucket"
  value       = aws_s3_bucket.serverless_deployment.id
}

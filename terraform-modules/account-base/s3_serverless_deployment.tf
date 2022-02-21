# We write the name and ARN of the S3 serverless-deployment bucket to SSM
# so that it can easily be read by a serverless.yml
resource "aws_ssm_parameter" "s3_serverless_deployment_arn" {
  name        = "/s3/serverless-deployment/arn"
  description = "The ARN of the S3 serverless deployment bucket"
  type        = "String"
  value       = aws_s3_bucket.serverless_deployment.arn

  tags = merge(
    { "Name" = "/s3/serverless-deployment/arn" },
    { "description" = "The ARN of the S3 serverless deployment bucket" },
    var.tags
  )
}

resource "aws_ssm_parameter" "s3_serverless_deployment_name" {
  name        = "/s3/serverless-deployment/name"
  description = "The name of the S3 serverless deployment bucket"
  type        = "String"
  value       = aws_s3_bucket.serverless_deployment.id

  tags = merge(
    { "Name" = "/s3/serverless-deployment/name" },
    { "description" = "The name of the S3 serverless deployment bucket" },
    var.tags
  )
}

resource "aws_s3_bucket_public_access_block" "serverless_deployment" {
  bucket = aws_s3_bucket.serverless_deployment.id

  ignore_public_acls      = true
  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket" "serverless_deployment" {
  bucket_prefix = "serverless-deployment-"
  force_destroy = true

  tags = merge(
    { "Name" = "serverless-deployment" },
    { "description" = "A bucket to store all serverless deployments in our account" },
    { "service" = "serverless" },
    var.tags
  )
}

resource "aws_s3_bucket_versioning" "serverless_deployment" {
  bucket = aws_s3_bucket.serverless_deployment.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "serverless_deployment" {
  bucket = aws_s3_bucket.serverless_deployment.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
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

  statement {
    sid    = "DenyInsecureUsage"
    effect = "Deny"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = ["*"]

    resources = ["${aws_s3_bucket.serverless_deployment.arn}/*"]

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
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

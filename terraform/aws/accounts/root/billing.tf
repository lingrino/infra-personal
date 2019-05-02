resource "aws_s3_bucket_public_access_block" "billing" {
  bucket = "${ aws_s3_bucket.billing.id }"

  ignore_public_acls      = true
  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_cur_report_definition" "lingrino" {
  report_name = "lingrino"

  s3_region = "us-east-1"
  s3_bucket = "${ aws_s3_bucket.billing.id }"

  time_unit                  = "HOURLY"
  format                     = "textORcsv"
  compression                = "GZIP"
  additional_schema_elements = ["RESOURCES"]
}

# NOTE - The s3 bucket must be owned by the organization owner. AWS does not
#        support delivery to a bucket in another account (the audit account).
# https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/billing-getting-started.html#step-2
resource "aws_s3_bucket" "billing" {
  bucket_prefix = "billing-"
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
    id                                     = "all-billing-lifecycle"
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
    map("Name", "billing"),
    map("description", "Stores all of our AWS billing reports"),
    map("service", "billing"),
    var.tags )
  }"
}

resource "aws_s3_bucket_policy" "billing" {
  bucket = "${ aws_s3_bucket.billing.id }"
  policy = "${ data.aws_iam_policy_document.bucket_policy_billing.json }"
}

# https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/billing-getting-started.html#step-2
data "aws_iam_policy_document" "bucket_policy_billing" {
  statement {
    sid    = "AWSBillingDeliveryAclCheck"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["billingreports.amazonaws.com"]
    }

    actions = [
      "s3:GetBucketAcl",
      "s3:GetBucketPolicy",
    ]

    resources = ["${ aws_s3_bucket.billing.arn }"]
  }

  statement {
    sid    = "AWSBillingDeliveryWrite"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["billingreports.amazonaws.com"]
    }

    actions = ["s3:PutObject"]

    resources = ["${ aws_s3_bucket.billing.arn }/*"]
  }
}

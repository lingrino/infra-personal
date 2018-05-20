locals {
  emails_bucket_name = "emails"
}

resource "aws_s3_bucket" "bucket_emails" {
  bucket_prefix = "${ local.emails_bucket_name }-"

  region        = "${ module.constants.aws_default_region }"
  acl           = "private"
  force_destroy = true

  lifecycle_rule {
    id      = "all-emails-lifecycle"
    prefix  = "/"
    enabled = true

    abort_incomplete_multipart_upload_days = 1

    transition {
      days          = "90"
      storage_class = "GLACIER"
    }
  }

  tags = "${ merge(
    map(
      "Name",
      "${ local.emails_bucket_name }"
    ),
    module.constants.tags_default )
  }"
}

resource "aws_s3_bucket_policy" "bucket_emails_policy" {
  bucket = "${ aws_s3_bucket.bucket_emails.id }"
  policy = "${ data.aws_iam_policy_document.bucket_emails_policy_data.json }"
}

data "aws_iam_policy_document" "bucket_emails_policy_data" {
  statement {
    sid    = "AllowSESPuts"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ses.amazonaws.com"]
    }

    actions   = ["s3:PutObject"]
    resources = ["${ aws_s3_bucket.bucket_emails.arn }/*"]

    condition {
      test     = "StringEquals"
      variable = "aws:Referer"
      values   = ["${ module.constants.aws_account_id }"]
    }
  }
}

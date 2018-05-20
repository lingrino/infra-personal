locals {
  srlingren_com_bucket_name = "srlingren.com"
}

resource "aws_s3_bucket" "bucket_srlingren_com" {
  bucket_prefix = "${ local.srlingren_com_bucket_name }-"
  region        = "${ module.constants.aws_default_region }"
  acl           = "private"
  force_destroy = true

  versioning {
    enabled = true
  }

  logging {
    target_bucket = "${ aws_s3_bucket.bucket_logs.id }"
    target_prefix = "s3/${ local.srlingren_com_bucket_name }/access-logs/"
  }

  lifecycle_rule {
    id                                     = "${ local.srlingren_com_bucket_name }-state-lifecycle"
    enabled                                = true
    abort_incomplete_multipart_upload_days = 1

    noncurrent_version_transition {
      days          = "30"
      storage_class = "GLACIER"
    }

    noncurrent_version_expiration {
      days = "300"
    }
  }

  tags = "${ merge(
    map(
      "Name",
      "${ local.srlingren_com_bucket_name }"
    ),
    module.constants.tags_default )
  }"
}

resource "aws_s3_bucket_policy" "bucket_srlingren_com_policy" {
  bucket = "${ aws_s3_bucket.bucket_srlingren_com.id }"
  policy = "${ data.aws_iam_policy_document.bucket_srlingren_com_policy_data.json }"
}

data "aws_iam_policy_document" "bucket_srlingren_com_policy_data" {
  statement {
    sid    = "AllowCloudFrontList"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["${ data.terraform_remote_state.cloudfront.access_identity_srlingren_com_arn }"]
    }

    actions   = ["s3:ListBucket"]
    resources = ["${ aws_s3_bucket.bucket_srlingren_com.arn }"]
  }

  statement {
    sid    = "AllowCloudFrontGet"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["${ data.terraform_remote_state.cloudfront.access_identity_srlingren_com_arn }"]
    }

    actions   = ["s3:GetObject"]
    resources = ["${ aws_s3_bucket.bucket_srlingren_com.arn }/*"]
  }
}

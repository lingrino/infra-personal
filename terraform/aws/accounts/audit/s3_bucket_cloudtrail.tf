module "s3_lingrino_cloudtrail" {
  source = "../../../../terraform-modules/s3//"

  name               = "lingrino-audit-usw2-cloudtrail"
  enable_logging     = false
  enable_object_lock = true
  policy             = data.aws_iam_policy_document.s3_lingrino_cloudtrail.json
}

data "aws_iam_policy_document" "s3_lingrino_cloudtrail" {
  statement {
    sid    = "AWSCloudTrailAclCheck"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions   = ["s3:GetBucketAcl"]
    resources = ["___ARN___"]
  }

  statement {
    sid    = "AWSCloudTrailWrite"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions = ["s3:PutObject"]

    resources = ["___ARN___/*"]

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }
}

output "bucket_cloudtrail_arn" {
  description = "arn of the cloudtrail bucket"
  value       = module.s3_lingrino_cloudtrail.arn
}

output "bucket_cloudtrail_name" {
  description = "name of the cloudtrail bucket"
  value       = module.s3_lingrino_cloudtrail.name
}

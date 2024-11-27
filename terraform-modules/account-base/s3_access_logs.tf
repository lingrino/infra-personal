module "s3_access_logs" {
  source = "../s3//"

  name               = "lingrino-${var.account_name}-usw2-s3-logs"
  enable_logging     = false
  enable_object_lock = true
  policy             = data.aws_iam_policy_document.s3_access_logs.json
}

data "aws_iam_policy_document" "s3_access_logs" {
  statement {
    sid    = "S3WriteLogs"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["logging.s3.amazonaws.com"]
    }

    actions   = ["s3:PutObject"]
    resources = ["___ARN___/*"]
  }
}

data "aws_iam_policy_document" "cf" {
  dynamic "statement" {
    for_each = var.enable_cloudfront_access ? [1] : []

    content {
      sid = "AllowCloudfrontGet"

      principals {
        type        = "Service"
        identifiers = ["cloudfront.amazonaws.com"]
      }

      actions   = ["s3:GetObject"]
      resources = ["${aws_s3_bucket.s3.arn}/*"]

      condition {
        test     = "StringLike"
        variable = "AWS:SourceArn"
        values   = ["arn:aws:cloudfront::${data.aws_caller_identity.s3.account_id}:distribution/*"]
      }
    }
  }
}

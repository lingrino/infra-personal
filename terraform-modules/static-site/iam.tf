resource "aws_iam_user" "deployer" {
  name          = "${var.name_prefix}-deployer"
  path          = "/service/static-sites/"
  force_destroy = true

  tags = merge(
    { "Name" = "${var.name_prefix}-deployer" },
    var.tags
  )
}

resource "aws_iam_access_key" "deployer" {
  user = aws_iam_user.deployer.name
}

resource "aws_iam_user_policy" "deployer" {
  name_prefix = "${var.name_prefix}-deployer-"
  user        = aws_iam_user.deployer.name
  policy      = data.aws_iam_policy_document.deployer.json
}

data "aws_iam_policy_document" "deployer" {
  statement {
    sid    = "AllowDiscoverBucket"
    effect = "Allow"

    actions = [
      "s3:ListBucket",
      "s3:GetBucketLocation",
    ]

    resources = [aws_s3_bucket.s3.arn]
  }

  statement {
    sid    = "AllowWriteToBucket"
    effect = "Allow"

    actions = [
      "s3:PutObject",
    ]

    resources = ["${aws_s3_bucket.s3.arn}/*"]
  }

  statement {
    sid    = "AllowCreateInvalidations"
    effect = "Allow"

    actions = [
      "cloudfront:CreateInvalidation",
      "cloudfront:GetInvalidation",
      "cloudfront:ListInvalidations",
    ]

    resources = [aws_cloudfront_distribution.cf.arn]
  }
}

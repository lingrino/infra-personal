resource "aws_iam_user" "circle_srlingren_com_deployer" {
  name          = "circle_srlingren_com_deployer"
  path          = "/service/"
  force_destroy = true
}

resource "aws_iam_access_key" "circle_srlingren_com_deployer_keys" {
  user = "${ aws_iam_user.circle_srlingren_com_deployer.name }"
}

resource "aws_iam_user_policy" "circle_srlingren_com_deployer_policy" {
  name   = "circle_srlingren_com_deployer_policy"
  user   = "${ aws_iam_user.circle_srlingren_com_deployer.name }"
  policy = "${ data.aws_iam_policy_document.circle_srlingren_com_deployer_policy_data.json }"
}

data "aws_iam_policy_document" "circle_srlingren_com_deployer_policy_data" {
  statement {
    sid    = "AllowListSrlingrenComBucket"
    effect = "Allow"

    actions   = ["s3:ListBucket"]
    resources = ["${ data.terraform_remote_state.s3.bucket_srlingren_com_arn }"]
  }

  statement {
    sid    = "AllowWriteSrlingrenComBucket"
    effect = "Allow"

    actions = [
      "s3:PutObject",
    ]

    resources = ["${ data.terraform_remote_state.s3.bucket_srlingren_com_arn }/*"]
  }

  statement {
    sid    = "AllowCreateInvalidations"
    effect = "Allow"

    actions = [
      "cloudfront:CreateInvalidation",
      "cloudfront:GetInvalidation",
      "cloudfront:ListInvalidations",
    ]

    resources = ["*"] # Cloudfront does not support resource level permissioning
  }
}

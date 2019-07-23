data "aws_iam_policy_document" "arp_terraform_cloud" {
  statement {
    sid = "TerraformCloudAssumeRole"

    principals {
      type        = "AWS"
      identifiers = [aws_iam_user.terraform_cloud.arn]
    }

    actions = ["sts:AssumeRole"]

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["true"]
    }
  }
}

resource "aws_config_aggregate_authorization" "example" {
  account_id = var.account_id_audit
  region     = var.config_authorization_region
}

data "aws_arn" "config_bucket" {
  arn = var.bucket_config_arn
}

resource "aws_config_configuration_recorder_status" "config" {
  name       = aws_config_configuration_recorder.config.name
  is_enabled = true

  depends_on = [aws_config_delivery_channel.config]
}

resource "aws_config_configuration_recorder" "config" {
  name     = "recorder-${var.account_name}"
  role_arn = aws_iam_role.config_recorder.arn

  recording_group {
    all_supported                 = true
    include_global_resource_types = true
  }
}

resource "aws_iam_role" "config_recorder" {
  name_prefix = "config-recorder-"
  description = "Allows AWS Config to record resource changes and write them to to S3"

  assume_role_policy = data.aws_iam_policy_document.arp_config_recorder.json

  tags = merge(
    { "Name" = "config-recorder" },
    { "description" = "Allows AWS Config to record resource changes and write them to to S3" },
    { "service" = "config" },
    var.tags
  )
}

resource "aws_iam_role_policy_attachment" "config_recorder_service" {
  role       = aws_iam_role.config_recorder.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSConfigRole"
}

resource "aws_iam_role_policy" "config_recorder_delivery" {
  name_prefix = "config-recorder-delivery-"

  role   = aws_iam_role.config_recorder.id
  policy = data.aws_iam_policy_document.config_recorder_delivery.json
}

data "aws_iam_policy_document" "arp_config_recorder" {
  statement {
    sid    = "AllowConfigAssume"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["config.amazonaws.com"]
    }

    actions = [
      "sts:AssumeRole",
    ]
  }
}

# https://docs.aws.amazon.com/config/latest/developerguide/iamrole-permissions.html
data "aws_iam_policy_document" "config_recorder_delivery" {
  statement {
    sid    = "AllowGetBucketACL"
    effect = "Allow"

    actions = ["s3:GetBucketAcl"]

    resources = [var.bucket_config_arn]
  }

  statement {
    sid    = "AllowWriteToS3Bucket"
    effect = "Allow"

    actions = ["s3:PutObject"]

    resources = ["${var.bucket_config_arn}/*"]

    condition {
      test     = "StringLike"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }
}

resource "aws_config_delivery_channel" "config" {
  name           = "delivery-channel-${var.account_name}"
  s3_bucket_name = data.aws_arn.config_bucket.resource

  depends_on = [aws_config_configuration_recorder.config]
}

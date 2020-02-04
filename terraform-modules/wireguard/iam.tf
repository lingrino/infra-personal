resource "aws_iam_role" "wg" {
  name_prefix        = "${var.name_prefix}-"
  assume_role_policy = data.aws_iam_policy_document.wg_arp.json

  tags = merge(
    { "Name" = var.name_prefix },
    var.tags,
  )
}

resource "aws_iam_role_policy" "wg" {
  name_prefix = "${var.name_prefix}-"
  role        = aws_iam_role.wg.id
  policy      = data.aws_iam_policy_document.wg_role.json
}

resource "aws_iam_instance_profile" "wg" {
  name_prefix = "${var.name_prefix}-"
  role        = aws_iam_role.wg.name
}

data "aws_iam_policy_document" "wg_arp" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = [
      "sts:AssumeRole",
    ]
  }
}

data "aws_iam_policy_document" "wg_role" {
  statement {
    effect = "Allow"

    actions = [
      "s3:GetBucketLocation",
      "s3:ListBucket",
    ]

    resources = [
      aws_s3_bucket.wg.arn,
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "${aws_s3_bucket.wg.arn}/*",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "secretsmanager:GetSecretValue",
    ]

    resources = [
      aws_secretsmanager_secret.wg.arn
    ]

    condition {
      test     = "ForAnyValue:StringEquals"
      variable = "secretsmanager:VersionStage"
      values   = ["AWSCURRENT"]
    }
  }

  statement {
    effect = "Allow"

    actions = [
      "ec2:AssociateAddress",
      "ec2:DisassociateAddress",
      "ec2:ModifyInstanceAttribute",
    ]

    resources = ["*"]
  }
}

resource "aws_sns_topic" "alarm_low_priority" {
  name         = "alarm_low_priority"
  display_name = "alarm_low_priority"

  # NOTE - CloudWatch does not support encrypted SNS topics
  # https://docs.aws.amazon.com/sns/latest/dg/sns-server-side-encryption.html#sns-what-permissions-for-sse
  # kms_master_key_id = "alias/aws/sns"
}

resource "aws_sns_topic_policy" "alarm_low_priority" {
  arn    = "${ aws_sns_topic.alarm_low_priority.arn }"
  policy = "${ data.aws_iam_policy_document.alarm_low_priority.json }"
}

data "aws_iam_policy_document" "alarm_low_priority" {
  statement {
    sid    = "AllowAllAccountsPublish"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["${ data.terraform_remote_state.organization.account_ids }"]
    }

    actions = [
      "SNS:Publish",
    ]

    resources = ["${ aws_sns_topic.alarm_high_priority.arn }"]
  }

  statement {
    sid    = "AllowAllAccountsCloudwatchPublish"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "SNS:Publish",
    ]

    resources = ["${ aws_sns_topic.alarm_high_priority.arn }"]

    condition {
      test     = "ArnLike"
      variable = "AWS:SourceArn"
      values   = ["${ formatlist("arn:aws:cloudwatch:*:%s:alarm:${ aws_sns_topic.alarm_high_priority.name }", data.terraform_remote_state.organization.account_ids ) }"]
    }
  }
}

output "sns_alarm_low_priority_arn" {
  description = "The ARN of the alarm_low_priority SNS topic in the Audit account"
  value       = "${ aws_sns_topic.alarm_low_priority.arn }"
}

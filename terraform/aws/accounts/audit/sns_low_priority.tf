resource "aws_sns_topic" "alarm_low_priority" {
  name         = "alarm_low_priority"
  display_name = "alarm_low_priority"

  kms_master_key_id = "alias/aws/sns"
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
      identifiers = ["${ formatlist("arn:aws:iam::%s:root", data.terraform_remote_state.organization.account_ids ) }"]
    }

    actions = ["SNS:Publish"]

    resources = ["${ aws_sns_topic.alarm_low_priority.arn }"]
  }
}

output "sns_alarm_low_priority_arn" {
  description = "The ARN of the alarm_low_priority SNS topic"
  value       = "${ aws_sns_topic.alarm_low_priority.arn }"
}

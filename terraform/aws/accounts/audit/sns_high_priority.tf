resource "aws_sns_topic" "alarm_high_priority" {
  name         = "alarm_high_priority"
  display_name = "alarm_high_priority"
}

resource "aws_sns_topic_policy" "alarm_high_priority" {
  arn    = aws_sns_topic.alarm_high_priority.arn
  policy = data.aws_iam_policy_document.alarm_high_priority.json
}

data "aws_iam_policy_document" "alarm_high_priority" {
  statement {
    sid    = "AllowAllAccountsPublish"
    effect = "Allow"

    principals {
      type = "AWS"
      identifiers = data.terraform_remote_state.organization.outputs.account_ids
    }

    actions = [
      "SNS:Publish",
    ]

    resources = [aws_sns_topic.alarm_high_priority.arn]
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

    resources = [aws_sns_topic.alarm_high_priority.arn]

    condition {
      test     = "ArnLike"
      variable = "AWS:SourceArn"
      values = formatlist("arn:aws:cloudwatch:*:%s:alarm:*", data.terraform_remote_state.organization.outputs.account_ids)
    }
  }

  statement {
    sid    = "AllowAllAccountsSESPublish"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ses.amazonaws.com"]
    }

    actions = [
      "SNS:Publish",
    ]

    resources = [aws_sns_topic.alarm_high_priority.arn]

    condition {
      test     = "StringEquals"
      variable = "AWS:Referer"
      values = formatlist("arn:aws:ses:*:%s:*", data.terraform_remote_state.organization.outputs.account_ids)
    }
  }
}

output "sns_alarm_high_priority_arn" {
  description = "The ARN of the alarm_high_priority SNS topic in the Audit account"
  value       = aws_sns_topic.alarm_high_priority.arn
}

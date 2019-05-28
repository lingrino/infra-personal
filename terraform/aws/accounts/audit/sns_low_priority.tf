resource "aws_sns_topic" "alarm_low_priority" {
  name         = "alarm_low_priority"
  display_name = "alarm_low_priority"

  tags = merge(
    { "Name" = "alarm_low_priority" },
    { "description" = "Messages to this topic will send the appropriate people a low priority alert" },
    { "service" = "sns" },
    var.tags
  )
}

resource "aws_sns_topic_policy" "alarm_low_priority" {
  arn    = aws_sns_topic.alarm_low_priority.arn
  policy = data.aws_iam_policy_document.alarm_low_priority.json
}

data "aws_iam_policy_document" "alarm_low_priority" {
  statement {
    sid    = "AllowAllAccountsPublish"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = data.terraform_remote_state.organization.outputs.account_ids
    }

    actions = [
      "SNS:Publish",
    ]

    resources = [aws_sns_topic.alarm_low_priority.arn]
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

    resources = [aws_sns_topic.alarm_low_priority.arn]

    condition {
      test     = "ArnLike"
      variable = "AWS:SourceArn"
      values   = formatlist("arn:aws:cloudwatch:*:%s:alarm:*", data.terraform_remote_state.organization.outputs.account_ids)
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

    resources = [aws_sns_topic.alarm_low_priority.arn]

    condition {
      test     = "ArnLike"
      variable = "AWS:SourceArn"
      values   = formatlist("arn:aws:ses:*:%s:*", data.terraform_remote_state.organization.outputs.account_ids)
    }
  }
}

output "sns_alarm_low_priority_arn" {
  description = "The ARN of the alarm_low_priority SNS topic in the Audit account"
  value       = aws_sns_topic.alarm_low_priority.arn
}

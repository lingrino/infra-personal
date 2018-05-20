resource "aws_cloudwatch_log_resource_policy" "route53_query_logging_policy" {
  policy_name     = "route53_query_logging_policy"
  policy_document = "${ data.aws_iam_policy_document.route53_query_logging_policy.json }"
}

data "aws_iam_policy_document" "route53_query_logging_policy" {
  statement {
    sid = "AllowRoute53QueryLogs"

    principals {
      type        = "Service"
      identifiers = ["route53.amazonaws.com"]
    }

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["arn:aws:logs:${ var.region }:${ module.constants.aws_account_id }:log-group:/aws/route53/*"]
  }
}

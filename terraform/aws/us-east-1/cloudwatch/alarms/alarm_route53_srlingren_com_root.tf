resource "aws_cloudwatch_metric_alarm" "route53_srlingren_com_root" {
  alarm_name        = "route53_srlingren_com_root"
  alarm_description = "Alarms when srlingren.com is down"

  namespace           = "AWS/Route53"
  metric_name         = "HealthCheckStatus"
  comparison_operator = "LessThanThreshold"

  threshold          = "1"
  statistic          = "Average"
  period             = "300"
  evaluation_periods = "2"

  dimensions {
    HealthCheckId = "${ data.terraform_remote_state.route53_srlingren_com.healthcheck_root_id }"
  }

  actions_enabled           = true
  treat_missing_data        = "breaching"
  ok_actions                = ["${ data.terraform_remote_state.sns_us_east_1.topic_alarm_high_priority_arn }"]
  alarm_actions             = ["${ data.terraform_remote_state.sns_us_east_1.topic_alarm_high_priority_arn }"]
  insufficient_data_actions = ["${ data.terraform_remote_state.sns_us_east_1.topic_alarm_high_priority_arn }"]
}

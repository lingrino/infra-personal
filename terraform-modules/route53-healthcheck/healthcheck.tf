resource "aws_route53_health_check" "check" {
  count = length(var.domains)

  cloudwatch_alarm_name   = var.domains[count.index]
  cloudwatch_alarm_region = data.aws_region.current.name

  fqdn          = var.domains[count.index]
  type          = var.healthcheck_type
  port          = var.healthcheck_port
  resource_path = var.healthcheck_path

  request_interval  = var.healthcheck_interval
  failure_threshold = var.healthcheck_failure_threshold

  tags = merge(
    {"Name" = var.domains[count.index]},
    var.tags,
  )
}

resource "aws_cloudwatch_metric_alarm" "check" {
  count             = length(var.domains)
  alarm_name        = var.domains[count.index]
  alarm_description = "Alarms when ${var.domains[count.index]} is down"

  namespace           = "AWS/Route53"
  metric_name         = "HealthCheckStatus"
  comparison_operator = "LessThanThreshold"

  threshold          = "1"
  statistic          = "Average"
  period             = "60"
  evaluation_periods = "2"

  dimensions = {
    HealthCheckId = element(aws_route53_health_check.check.*.id, count.index)
  }

  actions_enabled    = true
  treat_missing_data = "breaching"

  ok_actions                = [var.sns_arn]
  alarm_actions             = [var.sns_arn]
  insufficient_data_actions = [var.sns_arn]
}

resource "aws_route53_health_check" "check" {
  for_each = toset(var.domains)

  cloudwatch_alarm_name   = each.value
  cloudwatch_alarm_region = data.aws_region.current.name

  fqdn          = each.value
  type          = var.healthcheck_type
  port          = var.healthcheck_port
  resource_path = var.healthcheck_path

  request_interval  = var.healthcheck_interval
  failure_threshold = var.healthcheck_failure_threshold

  tags = merge(
    { "Name" = each.value },
    var.tags
  )
}

resource "aws_cloudwatch_metric_alarm" "check" {
  for_each = aws_route53_health_check.check

  alarm_name        = each.value.cloudwatch_alarm_name
  alarm_description = "Alarms when ${each.value.cloudwatch_alarm_name} is down"

  namespace           = "AWS/Route53"
  metric_name         = "HealthCheckStatus"
  comparison_operator = "LessThanThreshold"

  threshold          = "1"
  statistic          = "Average"
  period             = "60"
  evaluation_periods = "2"

  dimensions = {
    HealthCheckId = each.value.id
  }

  actions_enabled    = true
  treat_missing_data = "breaching"

  ok_actions                = [var.sns_arn]
  alarm_actions             = [var.sns_arn]
  insufficient_data_actions = [var.sns_arn]
}

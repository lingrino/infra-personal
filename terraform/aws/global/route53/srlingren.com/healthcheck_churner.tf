resource "aws_route53_health_check" "churner" {
  provider = "aws.us-east-1"

  reference_name          = "churner_srlingren_com"
  cloudwatch_alarm_name   = "churner_srlingren_com"
  cloudwatch_alarm_region = "us-east-1"

  fqdn          = "churner.${ var.bare_domain }"
  type          = "HTTPS"
  port          = 443
  resource_path = "/"

  failure_threshold = "5"
  request_interval  = "30"

  tags = "${ merge(
    map(
      "Name",
      "churner.${ var.bare_domain }"
    ),
    module.constants.tags_default )
  }"
}

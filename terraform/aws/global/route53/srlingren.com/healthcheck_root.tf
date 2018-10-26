resource "aws_route53_health_check" "root" {
  provider = "aws.us-east-1"

  reference_name          = "srlingren_com_root"
  cloudwatch_alarm_name   = "srlingren_com_root"
  cloudwatch_alarm_region = "us-east-1"

  fqdn          = "${ var.bare_domain }"
  type          = "HTTPS"
  port          = 443
  resource_path = "/"

  failure_threshold = "5"
  request_interval  = "30"

  tags = "${ merge(
    map(
      "Name",
      "${ var.bare_domain }"
    ),
    module.constants.tags_default )
  }"
}

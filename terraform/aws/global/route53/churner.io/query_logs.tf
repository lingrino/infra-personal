resource "aws_route53_query_log" "query_log" {
  zone_id                  = "${ aws_route53_zone.zone.zone_id }"
  cloudwatch_log_group_arn = "${ data.terraform_remote_state.cloudwatch_logs_us_east_1.log_group_route53_churner_io_arn }"
}

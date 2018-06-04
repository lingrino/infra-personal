output "log_group_route53_churner_io_arn" {
  value = "${ aws_cloudwatch_log_group.route53_churner_io.arn }"
}

output "log_group_route53_srlingren_com_arn" {
  value = "${ aws_cloudwatch_log_group.route53_srlingren_com.arn }"
}

output "log_group_route53_vaku_io_arn" {
  value = "${ aws_cloudwatch_log_group.route53_vaku_io.arn }"
}

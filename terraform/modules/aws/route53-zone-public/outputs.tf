output "healthcheck_root_id" {
  value = "${ aws_route53_health_check.root.id }"
}

output "healthcheck_churner_id" {
  value = "${ aws_route53_health_check.churner.id }"
}

module "healthcheck" {
  source = "../route53-healthcheck//"

  domains = ["${ local.healthcheck_domains }"]
  sns_arn = "${ var.healthcheck_sns_arn }"

  tags = "${ var.tags }"
}

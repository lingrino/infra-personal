module "healthcheck" {
  source = "../route53-healthcheck//"

  domains = var.healthcheck_cloudfront_enabled ? merge(local.healthcheck_domains, [aws_cloudfront_distribution.cf.domain_name]) : local.healthcheck_domains

  sns_arn = var.healthcheck_sns_arn

  tags = var.tags
}

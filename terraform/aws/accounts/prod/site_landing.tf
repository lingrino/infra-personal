# This static site is just meant to hold all of the sites that I am currently not using and
# display a basic landing page that is defined in the module.
module "site_landing" {
  source = "../../../../terraform-modules/static-site//"

  name_prefix = "site-landing"

  domain_name = "hoo.dev"
  zone_name   = "hoo.dev"

  sans_domain_names_to_zone_names = {
    "*.hoo.dev" = "hoo.dev"
  }

  healthcheck_sns_arn = data.terraform_remote_state.account_audit.outputs.sns_alarm_high_priority_arn
  bucket_logs_domain  = data.terraform_remote_state.account_audit.outputs.bucket_logs_cloudfront_domain

  tags = var.tags

  providers = {
    aws.cert = aws.cert
    aws.dns  = aws.dns
  }
}

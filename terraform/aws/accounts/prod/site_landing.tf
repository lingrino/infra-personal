# This static site is just meant to hold all of the sites that I am currently not using and
# display a basic landing page that is defined in the module.
module "site_landing" {
  source = "../../../../terraform-modules/static-site//"

  name_prefix = "site-landing"

  domain_name = "churner.io"
  zone_name   = "churner.io"

  sans_domain_names_to_zone_names = {
    "*.churner.io"   = "churner.io"
    "hoo.dev"        = "hoo.dev"
    "*.hoo.dev"      = "hoo.dev"
    "policies.dev"   = "policies.dev"
    "*.policies.dev" = "policies.dev"
    "releases.dev"   = "releases.dev"
    "*.releases.dev" = "releases.dev"
  }

  healthcheck_sns_arn = data.terraform_remote_state.account_audit.outputs.sns_alarm_high_priority_arn
  bucket_logs_domain  = data.terraform_remote_state.account_audit.outputs.bucket_logs_cloudfront_domain

  tags = var.tags
}

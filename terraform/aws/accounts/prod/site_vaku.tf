module "vaku" {
  source = "../../../../terraform-modules/static-site//"

  name_prefix = "vaku"

  domain_name = "vaku.dev"
  zone_name   = "vaku.dev"

  sans_domain_names_to_zone_names = {
    "*.vaku.dev" = "vaku.dev"
    "vaku.io"    = "vaku.io"
    "*.vaku.io"  = "vaku.io"
  }

  healthcheck_sns_arn = data.terraform_remote_state.account_audit.outputs.sns_alarm_high_priority_arn
  bucket_logs_domain  = data.terraform_remote_state.account_audit.outputs.bucket_logs_cloudfront_domain

  tags = var.tags

  providers = {
    aws.cert = aws.cert
    aws.dns  = aws.dns
  }
}

output "site_vaku_bucket_name" {
  value = module.vaku.bucket_name
}

output "site_vaku_distribution_id" {
  value = module.vaku.distribution_id
}

output "site_vaku_deployer_access_key_id" {
  value = module.vaku.deployer_access_key_id
}

output "site_vaku_deployer_secret_access_key" {
  value = module.vaku.deployer_secret_access_key
}

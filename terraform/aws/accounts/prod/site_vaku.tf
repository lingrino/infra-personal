module "vaku" {
  source = "../../../../terraform-modules/static-site//"

  name_prefix = "vaku"

  dns_names_to_zone_names = {
    "vaku.io"    = "vaku.io"
    "*.vaku.io"  = "vaku.io"
    "vaku.dev"   = "vaku.dev"
    "*.vaku.dev" = "vaku.dev"
  }

  healthcheck_sns_arn = "${ data.terraform_remote_state.account_audit.sns_alarm_high_priority_arn }"
  bucket_logs_domain  = "${ data.terraform_remote_state.account_audit.bucket_logs_cloudfront_domain }"

  tags = "${ var.tags }"
}

output "vaku_bucket_name" {
  value = "${ module.vaku.bucket_name }"
}

output "vaku_distribution_id" {
  value = "${ module.vaku.distribution_id }"
}

output "vaku_deployer_access_key_id" {
  value = "${ module.vaku.deployer_access_key_id }"
}

output "vaku_deployer_secret_access_key" {
  value = "${ module.vaku.deployer_secret_access_key }"
}

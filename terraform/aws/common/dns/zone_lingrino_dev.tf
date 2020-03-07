module "zone_lingrino_dev" {
  source = "../../../../terraform-modules/route53-zone-public//"

  domain            = "lingrino.dev"
  delegation_set_id = aws_route53_delegation_set.lingrino_prod.id

  keybase_record_value      = "keybase-site-verification=PdlLnMY9_7NaKjiMSMJ--QQXQaSHTFwb4sVmVBVT0bc"
  google_site_verifications = ["google-site-verification=vxDuPgFxbbnn0WDnOzSZVz2zzv_rZr6EUegsu2gF6KY"]
  ses_sns_arn               = data.terraform_remote_state.account_audit.outputs.sns_alarm_low_priority_arn

  enable_fastmail                      = true
  enable_fastmail_webmail_login_portal = true

  tags = var.tags

  providers = {
    aws = aws.prod
  }
}

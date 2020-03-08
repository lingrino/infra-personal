module "zone_lingrino_dev" {
  source = "../../../../terraform-modules/route53-zone-public//"

  domain            = "lingrino.dev"
  delegation_set_id = aws_route53_delegation_set.lingrino_prod.id

  enable_gsuite        = true
  keybase_record_value = "keybase-site-verification=PdlLnMY9_7NaKjiMSMJ--QQXQaSHTFwb4sVmVBVT0bc"
  google_site_verifications = [
    "google-site-verification=tqnkU2jHbxBeuUO8eQd90P_6bMwKletm5F6vgLu15xc",
    "google-site-verification=vxDuPgFxbbnn0WDnOzSZVz2zzv_rZr6EUegsu2gF6KY",
  ]

  ses_sns_arn = data.terraform_remote_state.account_audit.outputs.sns_alarm_low_priority_arn

  tags = var.tags

  providers = {
    aws = aws.prod
  }
}

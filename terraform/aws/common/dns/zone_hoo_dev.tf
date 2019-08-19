module "zone_hoo_dev" {
  source = "../../../../terraform-modules/route53-zone-public//"

  domain            = "hoo.dev"
  delegation_set_id = aws_route53_delegation_set.lingrino_prod.id

  keybase_record_value           = "keybase-site-verification=mXA2oi_ATtgTx1BqzRWOgswAVqXRoSK0LF1CSyoD3zg"
  google_site_verification_value = "google-site-verification=IlVlYTBjP_nWq4q1G_AgW5AjNSLQ9MNUPoH-uLcZCW8"
  ses_sns_arn                    = data.terraform_remote_state.account_audit.outputs.sns_alarm_low_priority_arn

  enable_fastmail                      = true
  enable_fastmail_webmail_login_portal = true

  tags = var.tags

  providers = {
    aws = aws.prod
  }
}

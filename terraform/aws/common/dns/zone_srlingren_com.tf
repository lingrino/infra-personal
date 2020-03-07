module "zone_srlingren_com" {
  source = "../../../../terraform-modules/route53-zone-public//"

  domain            = "srlingren.com"
  delegation_set_id = aws_route53_delegation_set.lingrino_prod.id

  keybase_record_value = "keybase-site-verification=bGi1F-LK1JuddMPjZlB84NL6kvSmQ1uK2Us0r1SMt1c"
  ses_sns_arn          = data.terraform_remote_state.account_audit.outputs.sns_alarm_low_priority_arn

  enable_fastmail                      = true
  enable_fastmail_webmail_login_portal = true

  tags = var.tags

  providers = {
    aws = aws.prod
  }
}

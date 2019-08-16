module "zone_srlingren_com" {
  source = "../../../../terraform-modules/route53-zone-public//"

  domain            = "srlingren.com"
  delegation_set_id = aws_route53_delegation_set.lingrino_prod.id

  keybase_record_value           = "keybase-site-verification=bGi1F-LK1JuddMPjZlB84NL6kvSmQ1uK2Us0r1SMt1c"
  google_site_verification_value = ""
  ses_sns_arn                    = data.terraform_remote_state.account_audit.outputs.sns_alarm_low_priority_arn

  tags = var.tags

  providers = {
    aws = aws.prod
  }
}

module "fastmail_srlingren_com" {
  source = "../../../../terraform-modules/fastmail//"

  domain_name = "srlingren.com"

  enable_webmail_login_portal = false

  providers = {
    aws = aws.prod
  }
}

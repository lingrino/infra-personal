module "zone_lingrino_com" {
  source = "../../../../terraform-modules/route53-zone-public//"

  domain            = "lingrino.com"
  delegation_set_id = aws_route53_delegation_set.lingrino_prod.id

  keybase_record_value = "keybase-site-verification=OSEFJcKRkkit1mlWF_9zDpsE0q3ocWV8AfDWtbDU6lo"
  ses_sns_arn          = data.terraform_remote_state.account_audit.outputs.sns_alarm_low_priority_arn

  tags = var.tags

  providers = {
    aws = aws.prod
  }
}

module "delegate_dev_lingrino_com" {
  source = "../../../../terraform-modules/route53-zone-delegation//"

  zone_id     = module.zone_lingrino_com.zone_id
  domain      = "dev.lingrino.com"
  nameservers = aws_route53_delegation_set.lingrino_dev.name_servers

  providers = {
    aws = aws.prod
  }
}

module "zone_dev_lingrino_com" {
  source = "../../../../terraform-modules/route53-zone-public//"

  domain            = "dev.lingrino.com"
  delegation_set_id = aws_route53_delegation_set.lingrino_dev.id

  ses_sns_arn                               = data.terraform_remote_state.account_audit.outputs.sns_alarm_low_priority_arn
  configure_google_domains_email_forwarding = false

  tags = var.tags

  providers = {
    aws = aws.dev
  }
}

module "ses_audit_lingrino_com" {
  source = "../../../../terraform-modules/ses-domain//"

  zone_name   = "lingrino.com"
  domain_name = "audit.lingrino.com"
  ses_sns_arn = data.terraform_remote_state.account_audit.outputs.sns_alarm_low_priority_arn

  providers = {
    aws.dns = aws.prod
    aws.ses = aws.audit
  }
}

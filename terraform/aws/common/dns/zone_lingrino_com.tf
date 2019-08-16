module "zone_lingrino_com" {
  source = "../../../../terraform-modules/route53-zone-public//"

  domain            = "lingrino.com"
  delegation_set_id = aws_route53_delegation_set.lingrino_prod.id

  keybase_record_value           = "keybase-site-verification=OSEFJcKRkkit1mlWF_9zDpsE0q3ocWV8AfDWtbDU6lo"
  google_site_verification_value = "google-site-verification=x960BR9hmXBErt3Hu1OzopZuf-CCkeOHCphwD4ZZHIY"
  ses_sns_arn                    = data.terraform_remote_state.account_audit.outputs.sns_alarm_low_priority_arn

  tags = var.tags

  providers = {
    aws = aws.prod
  }
}

module "fastmail_lingrino_com" {
  source = "../../../../terraform-modules/fastmail//"

  domain_name = "lingrino.com"

  enable_webmail_login_portal = true
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

  ses_sns_arn = data.terraform_remote_state.account_audit.outputs.sns_alarm_low_priority_arn

  tags = var.tags

  providers = {
    aws = aws.dev
  }
}

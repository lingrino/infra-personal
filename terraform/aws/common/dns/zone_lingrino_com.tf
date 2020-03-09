module "zone_lingrino_com" {
  source = "../../../../terraform-modules/route53-zone-public//"

  domain            = "lingrino.com"
  delegation_set_id = aws_route53_delegation_set.lingrino_prod.id

  enable_gsuite        = true
  keybase_record_value = "keybase-site-verification=OSEFJcKRkkit1mlWF_9zDpsE0q3ocWV8AfDWtbDU6lo"
  gsuite_dkim_value    = "v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAiHgGtni6fQyjayMdUE73YSMSFHGr6O5DX9eP1tvVIiY637jT83srK7udP+2Zyp3P0mLz72gmKIHF06FHHk7M3oCcrbrF8VKo47EBOAhRkwx56tyVv3jwRXE56IFhR/oK7g3uIwlbscBQQNS7YZ8Frsw5kiPjwfKE6cwjfFsWfwxNOfgpHCTkyJWAlO1xz85cMKBtqcvjYVjTAPpBlIDzV3rHJQpVRiqu2m9iU092P7M1jobgf3i6Z/CP7NCq9PmIcjGxioUJKLoXwp9n/qkvmKcQCf8x/pf7BttkO0ay0nZXAD3EOB8bovYv4giZZbSBadidpIAjYNmnjAj6H8DJQQIDAQAB"
  google_site_verifications = [
    "google-site-verification=x960BR9hmXBErt3Hu1OzopZuf-CCkeOHCphwD4ZZHIY",
    "google-site-verification=Z_0sabCX_ouSK55gpGCOfT94pJ3PS8opdHpWDfA2zY4",
  ]

  ses_sns_arn = data.terraform_remote_state.account_audit.outputs.sns_alarm_low_priority_arn

  tags = var.tags

  providers = {
    aws = aws.prod
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

module "zone_lingrino_com" {
  source = "../../terraform-modules/zone//"

  domain = "lingrino.com"

  ses_sns_arn          = data.terraform_remote_state.account_audit.outputs.sns_alarm_low_priority_arn
  github_record_value  = "f57d22fc6a"
  keybase_record_value = "keybase-site-verification=OSEFJcKRkkit1mlWF_9zDpsE0q3ocWV8AfDWtbDU6lo"

  enable_gsuite     = true
  gsuite_dkim_value = "v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAiHgGtni6fQyjayMdUE73YSMSFHGr6O5DX9eP1tvVIiY637jT83srK7udP+2Zyp3P0mLz72gmKIHF06FHHk7M3oCcrbrF8VKo47EBOAhRkwx56tyVv3jwRXE56IFhR/oK7g3uIwlbscBQQNS7YZ8Frsw5kiPjwfKE6cwjfFsWfwxNOfgpHCTkyJWAlO1xz85cMKBtqcvjYVjTAPpBlIDzV3rHJQpVRiqu2m9iU092P7M1jobgf3i6Z/CP7NCq9PmIcjGxioUJKLoXwp9n/qkvmKcQCf8x/pf7BttkO0ay0nZXAD3EOB8bovYv4giZZbSBadidpIAjYNmnjAj6H8DJQQIDAQAB"
  google_site_verifications = [
    "google-site-verification=x960BR9hmXBErt3Hu1OzopZuf-CCkeOHCphwD4ZZHIY",
    "google-site-verification=Z_0sabCX_ouSK55gpGCOfT94pJ3PS8opdHpWDfA2zY4",
  ]
}

resource "cloudflare_record" "lingrino_com" {
  for_each = toset(["lingrino.com", "www"])

  zone_id = module.zone_lingrino_com.zone_id
  proxied = true
  name    = each.key
  type    = "CNAME"
  value   = "site-personal.pages.dev"
}

module "ses_audit_lingrino_com" {
  source = "../../terraform-modules/ses-domain//"

  domain      = "audit.lingrino.com"
  zone_id     = module.zone_lingrino_com.zone_id
  ses_sns_arn = data.terraform_remote_state.account_audit.outputs.sns_alarm_low_priority_arn

  providers = {
    aws = aws.audit
  }
}

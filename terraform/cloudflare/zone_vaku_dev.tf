module "zone_vaku_dev" {
  source = "../../terraform-modules/zone//"

  domain                = "vaku.dev"
  cloudflare_account_id = var.cloudflare_account_id

  ses_sns_arn          = data.terraform_remote_state.account_audit.outputs.sns_alarm_low_priority_arn
  github_record_value  = "7438b66689"
  keybase_record_value = "keybase-site-verification=rErM6Ph75uLJbtGJuj6D9NsruOHOGWFRHh-5zFNc668"

  enable_gsuite     = true
  gsuite_dkim_value = "v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAjwdVNlTAai3AOReXvNYCUtsoSkNDGJ4bELqBL+pxZF/MdwBycGELUjuJ3mWjf+twxpjfjOJa1Q4FeHXOCIciFgaVSthtrRaM0BcGLHMCmEo8xSeSQ6p/uZ15lKnBXePk3ZQ5+YX7U8hfM/ZbtAlmZxWuMGn/jTrCIifBBGj+kV+IFRJEh4xaouT9wSqpXAksBmTEmjR+tp85Q7/Zgnt7J1mVLF76tR/MGGXyszNFa6Klx6qf1q14OwAQXf3Vx52v7qwa/JxPAkRlB7bZtDuw1C6mSPusZm0mxrQ8MXPr3kkYs1An36QfP0wmTuakg1BPNqi6PaVTMNI1Dsw5p/XUBQIDAQAB"
  google_site_verifications = [
    "google-site-verification=354Iab5XlE0DDXHQoN9G1PTHC3nlp1L5ehtJWzFJLRI",
    "google-site-verification=t2eRiObvW8NcHD8u8Wy7Ak2gG9KSihSXQUgLjFr8FEg"
  ]
}

resource "cloudflare_record" "vaku_dev" {
  for_each = toset(["vaku.dev", "www"])

  zone_id = module.zone_vaku_dev.zone_id
  proxied = true
  name    = each.key
  type    = "CNAME"
  value   = "vaku.pages.dev"
}

module "zone_vaku_dev" {
  source = "../../../../terraform-modules/route53-zone-public//"

  domain            = "vaku.dev"
  delegation_set_id = aws_route53_delegation_set.lingrino_prod.id

  enable_gsuite        = true
  keybase_record_value = "keybase-site-verification=rErM6Ph75uLJbtGJuj6D9NsruOHOGWFRHh-5zFNc668"
  gsuite_dkim_value    = "v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAjwdVNlTAai3AOReXvNYCUtsoSkNDGJ4bELqBL+pxZF/MdwBycGELUjuJ3mWjf+twxpjfjOJa1Q4FeHXOCIciFgaVSthtrRaM0BcGLHMCmEo8xSeSQ6p/uZ15lKnBXePk3ZQ5+YX7U8hfM/ZbtAlmZxWuMGn/jTrCIifBBGj+kV+IFRJEh4xaouT9wSqpXAksBmTEmjR+tp85Q7/Zgnt7J1mVLF76tR/MGGXyszNFa6Klx6qf1q14OwAQXf3Vx52v7qwa/JxPAkRlB7bZtDuw1C6mSPusZm0mxrQ8MXPr3kkYs1An36QfP0wmTuakg1BPNqi6PaVTMNI1Dsw5p/XUBQIDAQAB"
  google_site_verifications = [
    "google-site-verification=354Iab5XlE0DDXHQoN9G1PTHC3nlp1L5ehtJWzFJLRI",
    "google-site-verification=t2eRiObvW8NcHD8u8Wy7Ak2gG9KSihSXQUgLjFr8FEg"
  ]

  ses_sns_arn = data.terraform_remote_state.account_audit.outputs.sns_alarm_low_priority_arn

  tags = var.tags

  providers = {
    aws = aws.prod
  }
}

module "zone_srlingren_com" {
  source = "../../terraform-modules/zone//"

  domain                = "srlingren.com"
  cloudflare_account_id = cloudflare_account.account.id

  google_site_verifications = ["google-site-verification=y9QbGPES67hmtkoOIs1B9Fgfk-w4uceEemqtIL-jfYM"]
}

resource "cloudflare_record" "srlingren_com" {
  for_each = toset(["srlingren.com", "www"])

  zone_id = module.zone_srlingren_com.zone_id
  proxied = true
  name    = each.key
  type    = "CNAME"
  value   = "site-personal.pages.dev"
}

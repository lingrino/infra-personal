module "zone_vaku_dev" {
  source = "../../terraform-modules/zone//"

  domain                = "vaku.dev"
  cloudflare_account_id = cloudflare_account.account.id

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

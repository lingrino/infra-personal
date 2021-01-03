resource "cloudflare_record" "txt_gsuite" {
  count = var.enable_gsuite ? 1 : 0

  zone_id = cloudflare_zone.zone.id
  name    = "@"
  type    = "TXT"
  value   = "v=spf1 include:_spf.google.com ~all"
}

resource "cloudflare_record" "mx_gsuite_verification" {
  for_each = var.enable_gsuite ? {
    0 = { priority = 1, value = "aspmx.l.google.com" }
    1 = { priority = 5, value = "alt1.aspmx.l.google.com" }
    2 = { priority = 5, value = "alt2.aspmx.l.google.com" }
    3 = { priority = 10, value = "alt3.aspmx.l.google.com" }
    4 = { priority = 10, value = "alt4.aspmx.l.google.com" }
  } : {}

  zone_id  = cloudflare_zone.zone.id
  name     = var.domain
  type     = "MX"
  priority = each.value["priority"]
  value    = each.value["value"]
}

resource "cloudflare_record" "cname_gsuite_custom_urls" {
  for_each = var.enable_gsuite ? toset(["mail", "calendar", "drive"]) : []

  zone_id = cloudflare_zone.zone.id
  name    = "${each.key}.${var.domain}"
  type    = "CNAME"
  value   = "ghs.googlehosted.com"
}

resource "cloudflare_record" "txt_gsuite_dkim" {
  count = var.gsuite_dkim_value != "" ? 1 : 0

  zone_id = cloudflare_zone.zone.id
  name    = "google._domainkey"
  type    = "TXT"
  value   = var.gsuite_dkim_value
}

resource "cloudflare_record" "txt_gsuite_dmarc" {
  count = var.gsuite_dkim_value != "" ? 1 : 0

  zone_id = cloudflare_zone.zone.id
  name    = "_dmarc"
  type    = "TXT"
  value   = "v=DMARC1; p=reject; sp=reject; adkim=s; aspf=s; pct=100; rua=mailto:sean+dmarc@lingrino.com"
}

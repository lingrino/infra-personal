resource "cloudflare_record" "txt_gsuite" {
  count = var.enable_gsuite ? 1 : 0

  zone_id = cloudflare_zone.zone.id
  name    = "@"
  type    = "TXT"
  content = "v=spf1 include:_spf.google.com ~all"
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
  content  = each.value["value"]
}

resource "cloudflare_record" "txt_gsuite_dkim" {
  count = var.gsuite_dkim_value != "" ? 1 : 0

  zone_id = cloudflare_zone.zone.id
  name    = "google._domainkey"
  type    = "TXT"
  content = var.gsuite_dkim_value
}

resource "cloudflare_record" "txt_gsuite_dmarc" {
  count = var.gsuite_dkim_value != "" ? 1 : 0

  zone_id = cloudflare_zone.zone.id
  name    = "_dmarc"
  type    = "TXT"
  content = "v=DMARC1; p=reject; sp=reject; adkim=s; aspf=s; pct=100; rua=mailto:sean+dmarc@lingren.com"
}

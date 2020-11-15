resource "cloudflare_record" "txt_base" {
  for_each = toset(var.google_site_verifications)

  zone_id = cloudflare_zone.zone.id
  name    = "@"
  type    = "TXT"
  value   = each.key
}

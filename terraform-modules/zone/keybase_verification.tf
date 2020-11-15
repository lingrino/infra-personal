resource "cloudflare_record" "txt_keybase" {
  count = var.keybase_record_value != "" ? 1 : 0

  zone_id = cloudflare_zone.zone.id
  name    = "_keybase"
  type    = "TXT"
  value   = var.keybase_record_value
}

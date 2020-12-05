resource "cloudflare_record" "txt_github" {
  count = var.github_record_value != "" ? 1 : 0

  zone_id = cloudflare_zone.zone.id
  name    = "_github-challenge-lingrino-org"
  type    = "TXT"
  value   = var.github_record_value
}

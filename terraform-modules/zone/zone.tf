resource "cloudflare_zone" "zone" {
  account_id = var.cloudflare_account_id
  zone       = var.domain
}

resource "cloudflare_zone_dnssec" "zone" {
  zone_id = cloudflare_zone.zone.id
}

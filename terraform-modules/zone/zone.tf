resource "cloudflare_zone" "zone" {
  zone = var.domain
}

resource "cloudflare_zone_dnssec" "zone" {
  zone_id = cloudflare_zone.zone.id
}

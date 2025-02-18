resource "cloudflare_zone" "zone" {
  name = var.domain

  account = {
    id = var.cloudflare_account_id
  }

}

resource "cloudflare_zone_dnssec" "zone" {
  zone_id = cloudflare_zone.zone.id
  status  = "active"
}

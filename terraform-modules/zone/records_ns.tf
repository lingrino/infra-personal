resource "cloudflare_record" "ns" {
  for_each = var.skip_ns ? [] : toset(cloudflare_zone.zone.name_servers)

  zone_id = cloudflare_zone.zone.id
  name    = var.domain
  type    = "NS"
  value   = each.key
}

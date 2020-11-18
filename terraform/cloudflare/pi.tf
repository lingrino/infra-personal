locals {
  hostnames_pi = [
    "pi.lingrino.dev",
    "home.lingrino.dev",
  ]
  hostnames_adguard = [
    "ad.lingrino.dev",
    "adg.lingrino.dev",
    "adguard.lingrino.dev",
  ]
  hostnames_traefik = [
    "lb.lingrino.dev",
    "traefik.lingrino.dev",
  ]
  hostnames_cockpit = [
    "cp.lingrino.dev",
    "cockpit.lingrino.dev",
  ]
}

# Hostnames for tailscale devices
resource "cloudflare_record" "pi_lingrino_dev" {
  for_each = toset(concat(
    local.hostnames_pi,
    local.hostnames_adguard,
    local.hostnames_traefik,
    local.hostnames_cockpit
  ))

  zone_id = module.zone_lingrino_dev.zone_id
  proxied = true
  name    = each.key
  type    = "CNAME"
  value   = "ba6449e1-9ff4-4046-898c-07d6373404f6.cfargotunnel.com"
}

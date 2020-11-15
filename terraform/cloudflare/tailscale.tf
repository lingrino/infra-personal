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
  name    = each.key
  type    = "A"
  value   = "100.106.105.28"
}

resource "cloudflare_record" "phone_lingrino_dev" {
  zone_id = module.zone_lingrino_dev.zone_id
  name    = "phone.lingrino.dev."
  type    = "A"
  value   = "100.100.225.57"
}

resource "cloudflare_record" "ipad_lingrino_dev" {
  zone_id = module.zone_lingrino_dev.zone_id
  name    = "ipad.lingrino.dev."
  type    = "A"
  value   = "100.127.107.107"
}

resource "cloudflare_record" "work_lingrino_dev" {
  zone_id = module.zone_lingrino_dev.zone_id
  name    = "work.lingrino.dev."
  type    = "A"
  value   = "100.92.251.90"
}

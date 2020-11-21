locals {
  tunnel_uuid = "46ca3688-fb9f-48c0-9886-170661852b3e.cfargotunnel.com"
  hostnames_home = [
    "home",
    "adguard",
    "cockpit",
  ]
}

resource "cloudflare_access_application" "home" {
  for_each = toset(local.hostnames_home)
  account_id = var.cloudflare_account_id

  name             = each.key
  domain           = "${each.key}.lingrino.dev"
  session_duration = "168h" # 1 week
}

resource "cloudflare_access_policy" "home" {
  for_each = cloudflare_access_application.home

  account_id = var.cloudflare_account_id
  application_id = each.value.id

  name           = each.value.name
  precedence     = "1"
  decision       = "allow"

  include {
    group = [cloudflare_access_group.admin.id]
  }
}

resource "cloudflare_record" "home" {
  for_each = cloudflare_access_application.home

  zone_id = module.zone_lingrino_dev.zone_id
  proxied = true
  name    = each.value.domain
  type    = "CNAME"
  value   = local.tunnel_uuid
}

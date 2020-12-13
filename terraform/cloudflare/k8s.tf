locals {
  tunnel_uuid_k8s = "4f6493bb-48d1-479a-895a-5869ee2cb09b.cfargotunnel.com"
  hostnames_k8s = [
    "k8s",
    "vault"
  ]
}

resource "cloudflare_access_application" "k8s" {
  for_each   = toset(local.hostnames_k8s)
  account_id = var.cloudflare_account_id

  name             = each.key
  domain           = "${each.key}.lingrino.dev"
  session_duration = "168h" # 1 week
}

resource "cloudflare_access_policy" "k8s" {
  for_each = cloudflare_access_application.k8s

  account_id     = var.cloudflare_account_id
  application_id = each.value.id

  name       = each.value.name
  precedence = 1
  decision   = "allow"

  include {
    group = [cloudflare_access_group.admin.id]
  }
}

resource "cloudflare_record" "k8s" {
  for_each = cloudflare_access_application.k8s

  zone_id = module.zone_lingrino_dev.zone_id
  proxied = true
  name    = each.value.domain
  type    = "CNAME"
  value   = local.tunnel_uuid_k8s
}

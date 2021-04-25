module "zone_sla_how" {
  source = "../../terraform-modules/zone//"

  domain         = "sla.how"
  verify_ses     = false
  enable_caching = false
}

resource "cloudflare_record" "sla_how" {
  for_each = toset(["sla.how", "www"])

  zone_id = module.zone_sla_how.zone_id
  proxied = true
  name    = each.key
  type    = "CNAME"
  value   = "uptime-pcd3.pages.dev"
}

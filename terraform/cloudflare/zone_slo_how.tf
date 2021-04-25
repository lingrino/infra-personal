module "zone_slo_how" {
  source = "../../terraform-modules/zone//"

  domain         = "slo.how"
  verify_ses     = false
  enable_caching = false
}

resource "cloudflare_record" "slo_how" {
  for_each = toset(["slo.how", "www"])

  zone_id = module.zone_slo_how.zone_id
  proxied = true
  name    = each.key
  type    = "CNAME"
  value   = "uptime-pcd3.pages.dev"
}

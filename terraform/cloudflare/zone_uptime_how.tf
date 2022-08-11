module "zone_uptime_how" {
  source = "../../terraform-modules/zone//"

  domain                = "uptime.how"
  cloudflare_account_id = var.cloudflare_account_id

  verify_ses     = false
  enable_caching = false
}

resource "cloudflare_record" "uptime_how" {
  for_each = toset(["uptime.how", "www"])

  zone_id = module.zone_uptime_how.zone_id
  proxied = true
  name    = each.key
  type    = "CNAME"
  value   = "uptime-pcd3.pages.dev"
}

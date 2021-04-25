module "zone_availability_how" {
  source = "../../terraform-modules/zone//"

  domain         = "availability.how"
  verify_ses     = false
  enable_caching = false
}

resource "cloudflare_record" "availability_how" {
  for_each = toset(["availability.how", "www"])

  zone_id = module.zone_availability_how.zone_id
  proxied = true
  name    = each.key
  type    = "CNAME"
  value   = "uptime-pcd3.pages.dev"
}

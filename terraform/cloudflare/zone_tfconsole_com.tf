module "zone_tfconsole_com" {
  source = "../../terraform-modules/zone//"

  domain                = "tfconsole.com"
  cloudflare_account_id = var.cloudflare_account_id

  skip_ns        = true
  verify_ses     = false
  enable_caching = false
}

resource "cloudflare_record" "tfconsole_com_a" {
  for_each = toset(["tfconsole.com", "www"])

  zone_id = module.zone_tfconsole_com.zone_id
  name    = each.key
  type    = "A"
  value   = "213.188.217.14"
}

resource "cloudflare_record" "tfconsole_com_aaaa" {
  for_each = toset(["tfconsole.com", "www"])

  zone_id = module.zone_tfconsole_com.zone_id
  name    = each.key
  type    = "AAAA"
  value   = "2a09:8280:1::1d97"
}

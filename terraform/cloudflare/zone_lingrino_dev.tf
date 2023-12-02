module "zone_lingrino_dev" {
  source = "../../terraform-modules/zone//"

  domain                = "lingrino.dev"
  cloudflare_account_id = cloudflare_account.account.id

  enable_gsuite     = true
  gsuite_dkim_value = "v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAyRi4TbeyZb+hMwV586JcQM9vetlu1wh/aB+WowPA3zS1kCr1pD3tEsW95hZ24H8/B9q0gRsrK1rZuJESLFraPPv47k2Qds+HMDDCcyC89pGeFEJ9UHbBvxmAvPvb/hjLzQMS68rx94Ag+hro119XpIkD1/B0Gd99/4OGSupQG54U4O2gnymZjWepGLDa0eFXKpolc3U+3xnHIte52Ee4E8CWYBNZ3wOWw6j2guzTNill1ecPBpSrGzaJ7EMhWbDdwjnI3aPLmCoqu/zsJUDSEE8Pbphi2ddsoO7vqOeiVYlSlmZYPsiJBxQuRzXWO+6W4hxC9Ukf5TxpFNkY8qRalQIDAQAB"
  google_site_verifications = [
    "google-site-verification=tqnkU2jHbxBeuUO8eQd90P_6bMwKletm5F6vgLu15xc",
    "google-site-verification=vxDuPgFxbbnn0WDnOzSZVz2zzv_rZr6EUegsu2gF6KY",
  ]
}

resource "cloudflare_record" "lingrino_dev" {
  for_each = toset(["lingrino.dev", "www"])

  zone_id = module.zone_lingrino_dev.zone_id
  proxied = true
  name    = each.key
  type    = "CNAME"
  value   = "site-personal.pages.dev"
}

locals {
  tailscale_records = {
    pi      = "100.105.134.53"
    home    = "100.105.134.53"
    cockpit = "100.105.134.53"
    mac     = "100.70.4.79"
    ipad    = "100.85.226.33"
    phone   = "100.123.179.105"
    work    = "100.74.67.97"
  }
}

resource "cloudflare_record" "tailscale_records" {
  for_each = local.tailscale_records

  zone_id = module.zone_lingrino_dev.zone_id
  name    = each.key
  type    = "A"
  value   = each.value
}

module "zone_lingrino_dev" {
  source = "../../terraform-modules/zone//"

  domain = "lingrino.dev"

  enable_argo          = true
  enable_caching       = false
  ses_sns_arn          = data.terraform_remote_state.account_audit.outputs.sns_alarm_low_priority_arn
  github_record_value  = "19bf167331"
  keybase_record_value = "keybase-site-verification=PdlLnMY9_7NaKjiMSMJ--QQXQaSHTFwb4sVmVBVT0bc"

  enable_gsuite     = true
  gsuite_dkim_value = "v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAyRi4TbeyZb+hMwV586JcQM9vetlu1wh/aB+WowPA3zS1kCr1pD3tEsW95hZ24H8/B9q0gRsrK1rZuJESLFraPPv47k2Qds+HMDDCcyC89pGeFEJ9UHbBvxmAvPvb/hjLzQMS68rx94Ag+hro119XpIkD1/B0Gd99/4OGSupQG54U4O2gnymZjWepGLDa0eFXKpolc3U+3xnHIte52Ee4E8CWYBNZ3wOWw6j2guzTNill1ecPBpSrGzaJ7EMhWbDdwjnI3aPLmCoqu/zsJUDSEE8Pbphi2ddsoO7vqOeiVYlSlmZYPsiJBxQuRzXWO+6W4hxC9Ukf5TxpFNkY8qRalQIDAQAB"
  google_site_verifications = [
    "google-site-verification=tqnkU2jHbxBeuUO8eQd90P_6bMwKletm5F6vgLu15xc",
    "google-site-verification=vxDuPgFxbbnn0WDnOzSZVz2zzv_rZr6EUegsu2gF6KY",
  ]
}

# https://developers.cloudflare.com/workers/platform/routes#subdomains-must-have-a-dns-record
# (sub)domains must have a record associated with them for cloudflare workers to respond even if the
# worker is the only thing that should respond (static site). 100:: is the reserved discard prefix
# which forces cloudflare to create records that the worker runs against.
resource "cloudflare_record" "lingrino_dev_discard" {
  for_each = toset(["@", "www"])

  zone_id = module.zone_lingrino_dev.zone_id
  proxied = true
  name    = each.key
  type    = "AAAA"
  value   = "100::"
}

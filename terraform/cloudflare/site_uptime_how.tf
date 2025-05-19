module "zone_uptime_how" {
  source = "../../terraform-modules/zone//"

  domain                = "uptime.how"
  cloudflare_account_id = data.cloudflare_account.account.account_id

  google_site_verifications = [
    "google-site-verification=5RIxGFnjg_F2p4U4JHHdWYvt1JtynJF0xI2Iyzt_nQA", # https://search.google.com/search-console/welcome
  ]
}

resource "cloudflare_dns_record" "uptime_how" {
  zone_id = module.zone_uptime_how.id
  proxied = true
  name    = "uptime.how"
  type    = "CNAME"
  ttl     = 1
  content = "uptime-pcd3.pages.dev"
}

resource "cloudflare_pages_domain" "uptime" {
  account_id = data.cloudflare_account.account.account_id
  # project_name = cloudflare_pages_project.uptime.name
  project_name = "uptime"
  name         = "uptime.how"
}

# https://github.com/cloudflare/terraform-provider-cloudflare/issues/5093
# tfim 'cloudflare_pages_project.uptime' '27a6422e1d64fbe9408ab703847ecdab/uptime'
# resource "cloudflare_pages_project" "uptime" {
#   account_id        = data.cloudflare_account.account.account_id
#   name              = "uptime"
#   production_branch = "main"

#   build_config = {
#     build_command       = "npm run build"
#     destination_dir     = ".svelte-kit/cloudflare"
#     build_caching       = true
#     root_dir            = ""
#     web_analytics_tag   = ""
#     web_analytics_token = ""
#   }

#   deployment_configs = {
#     preview = {
#       fail_open           = true
#       compatibility_date  = "2024-11-11" # https://developers.cloudflare.com/workers/configuration/compatibility-dates/#change-history
#       compatibility_flags = []
#       usage_model         = "standard"
#     }
#     production = {
#       fail_open           = true
#       compatibility_date  = "2024-11-11" # https://developers.cloudflare.com/workers/configuration/compatibility-dates/#change-history
#       compatibility_flags = []
#       usage_model         = "standard"
#     }
#   }
# }

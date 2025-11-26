module "zone_lingrino_com" {
  source = "../../terraform-modules/zone//"

  domain                = "lingrino.com"
  cloudflare_account_id = data.cloudflare_account.account.account_id

  enable_gsuite     = true
  gsuite_dkim_value = "v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAiHgGtni6fQyjayMdUE73YSMSFHGr6O5DX9eP1tvVIiY637jT83srK7udP+2Zyp3P0mLz72gmKIHF06FHHk7M3oCcrbrF8VKo47EBOAhRkwx56tyVv3jwRXE56IFhR/oK7g3uIwlbscBQQNS7YZ8Frsw5kiPjwfKE6cwjfFsWfwxNOfgpHCTkyJWAlO1xz85cMKBtqcvjYVjTAPpBlIDzV3rHJQpVRiqu2m9iU092P7M1jobgf3i6Z/CP7NCq9PmIcjGxioUJKLoXwp9n/qkvmKcQCf8x/pf7BttkO0ay0nZXAD3EOB8bovYv4giZZbSBadidpIAjYNmnjAj6H8DJQQIDAQAB"
  google_site_verifications = [
    "google-site-verification=Z_0sabCX_ouSK55gpGCOfT94pJ3PS8opdHpWDfA2zY4", # https://admin.google.com
    "google-site-verification=x960BR9hmXBErt3Hu1OzopZuf-CCkeOHCphwD4ZZHIY", # https://search.google.com/search-console/welcome
  ]
}

resource "cloudflare_dns_record" "lingrino_com" {
  zone_id = module.zone_lingrino_com.id
  proxied = true
  name    = "lingrino.com"
  type    = "CNAME"
  ttl     = 1
  content = "site-personal.pages.dev"
}

resource "cloudflare_pages_domain" "website" {
  account_id   = data.cloudflare_account.account.account_id
  project_name = "website"
  name         = "lingrino.com"
}

resource "cloudflare_pages_project" "website" {
  account_id        = data.cloudflare_account.account.account_id
  name              = "website"
  production_branch = "main"

  build_config = {
    build_command       = "go run build.go"
    destination_dir     = "public"
    build_caching       = true
    root_dir            = ""
    web_analytics_tag   = ""
    web_analytics_token = ""
  }

  deployment_configs = {
    preview = {
      fail_open           = true
      compatibility_date  = "2025-09-15" # https://developers.cloudflare.com/workers/configuration/compatibility-dates/#change-history
      compatibility_flags = []
      usage_model         = "standard"
    }
    production = {
      fail_open           = true
      compatibility_date  = "2025-09-15" # https://developers.cloudflare.com/workers/configuration/compatibility-dates/#change-history
      compatibility_flags = []
      usage_model         = "standard"
    }
  }
}

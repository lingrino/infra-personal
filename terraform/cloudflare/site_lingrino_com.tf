module "zone_lingrino_com" {
  source = "../../terraform-modules/zone//"

  domain                = "lingrino.com"
  cloudflare_account_id = cloudflare_account.account.id

  enable_gsuite     = true
  gsuite_dkim_value = "v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAiHgGtni6fQyjayMdUE73YSMSFHGr6O5DX9eP1tvVIiY637jT83srK7udP+2Zyp3P0mLz72gmKIHF06FHHk7M3oCcrbrF8VKo47EBOAhRkwx56tyVv3jwRXE56IFhR/oK7g3uIwlbscBQQNS7YZ8Frsw5kiPjwfKE6cwjfFsWfwxNOfgpHCTkyJWAlO1xz85cMKBtqcvjYVjTAPpBlIDzV3rHJQpVRiqu2m9iU092P7M1jobgf3i6Z/CP7NCq9PmIcjGxioUJKLoXwp9n/qkvmKcQCf8x/pf7BttkO0ay0nZXAD3EOB8bovYv4giZZbSBadidpIAjYNmnjAj6H8DJQQIDAQAB"
  google_site_verifications = [
    "google-site-verification=Z_0sabCX_ouSK55gpGCOfT94pJ3PS8opdHpWDfA2zY4", # https://admin.google.com
    "google-site-verification=x960BR9hmXBErt3Hu1OzopZuf-CCkeOHCphwD4ZZHIY", # https://search.google.com/search-console/welcome
  ]
}

resource "cloudflare_record" "lingrino_com" {
  zone_id = module.zone_lingrino_com.id
  proxied = true
  name    = "lingrino.com"
  type    = "CNAME"
  value   = "site-personal.pages.dev"
}

resource "cloudflare_pages_domain" "website" {
  account_id   = cloudflare_account.account.id
  project_name = cloudflare_pages_project.website.name
  domain       = "lingrino.com"
}

resource "cloudflare_pages_project" "website" {
  account_id        = cloudflare_account.account.id
  name              = "website"
  production_branch = "main"

  source {
    type = "github"

    config {
      owner             = "lingrino"
      repo_name         = "website"
      production_branch = "main"
    }
  }

  build_config {
    destination_dir = "www"
  }

  deployment_configs {
    preview {
      fail_open                            = true
      always_use_latest_compatibility_date = true
    }
    production {
      fail_open          = true
      compatibility_date = "2023-12-01" # https://developers.cloudflare.com/workers/configuration/compatibility-dates/#change-history
    }
  }
}

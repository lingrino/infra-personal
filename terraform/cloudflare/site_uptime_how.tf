module "zone_uptime_how" {
  source = "../../terraform-modules/zone//"

  domain                = "uptime.how"
  cloudflare_account_id = cloudflare_account.account.id

  google_site_verifications = [
    "google-site-verification=5RIxGFnjg_F2p4U4JHHdWYvt1JtynJF0xI2Iyzt_nQA" # https://search.google.com/search-console/welcome
  ]
}

resource "cloudflare_record" "uptime_how" {
  zone_id = module.zone_uptime_how.id
  proxied = true
  name    = "uptime.how"
  type    = "CNAME"
  value   = "uptime-pcd3.pages.dev"
}

resource "cloudflare_pages_domain" "uptime" {
  account_id   = cloudflare_account.account.id
  project_name = cloudflare_pages_project.uptime.name
  domain       = "uptime.how"
}

resource "cloudflare_pages_project" "uptime" {
  account_id        = cloudflare_account.account.id
  name              = "uptime"
  production_branch = "main"

  source {
    type = "github"

    config {
      owner             = "lingrino"
      repo_name         = "uptime"
      production_branch = "main"
    }
  }

  build_config {
    build_command   = "npm run build"
    destination_dir = ".svelte-kit/cloudflare"
    build_caching   = true
  }

  deployment_configs {
    preview {
      fail_open                            = true
      always_use_latest_compatibility_date = true
      usage_model                          = "standard"
    }
    production {
      fail_open          = true
      compatibility_date = "2023-12-01" # https://developers.cloudflare.com/workers/configuration/compatibility-dates/#change-history
      usage_model        = "standard"
    }
  }
}

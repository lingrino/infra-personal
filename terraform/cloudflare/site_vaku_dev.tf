module "zone_vaku_dev" {
  source = "../../terraform-modules/zone//"

  domain                = "vaku.dev"
  cloudflare_account_id = cloudflare_account.account.id

  google_site_verifications = [
    "google-site-verification=t2eRiObvW8NcHD8u8Wy7Ak2gG9KSihSXQUgLjFr8FEg", # https://search.google.com/search-console
  ]
}

resource "cloudflare_record" "vaku_dev" {
  zone_id = module.zone_vaku_dev.id
  proxied = true
  name    = "vaku.dev"
  type    = "CNAME"
  value   = "vaku.pages.dev"
}

resource "cloudflare_pages_domain" "vaku" {
  account_id   = cloudflare_account.account.id
  project_name = cloudflare_pages_project.vaku.name
  domain       = "vaku.dev"
}

resource "cloudflare_pages_project" "vaku" {
  account_id        = cloudflare_account.account.id
  name              = "vaku"
  production_branch = "main"

  source {
    type = "github"

    config {
      owner             = "lingrino"
      repo_name         = "vaku"
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

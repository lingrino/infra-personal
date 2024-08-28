module "zone_lingren_org" {
  source = "../../terraform-modules/zone//"

  domain                = "lingren.org"
  cloudflare_account_id = cloudflare_account.account.id

  google_site_verifications = [
    "google-site-verification=2wlyDNZ9mK6gUXJAYzqixYSIv84J-2bVFWmzNotzshI", # https://search.google.com/search-console/welcome
  ]
}

resource "cloudflare_record" "star_lingren_org" {
  zone_id = module.zone_lingren_org.id
  proxied = true
  name    = "*.lingren.org"
  type    = "CNAME"
  content = "lingrino.com" # superseded by below redirect
}

resource "cloudflare_ruleset" "redirect_lingren_org_to_lingrino_com" {
  zone_id = module.zone_lingren_org.id

  name        = "redirect"
  description = "redirect *.lingren.org to lingrino.com"

  kind  = "zone"
  phase = "http_request_dynamic_redirect"

  rules {
    action      = "redirect"
    description = "redirect *.lingren.org to lingrino.com"
    expression  = "true"

    action_parameters {
      from_value {
        status_code = 301
        target_url {
          value = "https://lingrino.com"
        }
      }
    }
  }
}

module "zone_seanlingren_com" {
  source = "../../terraform-modules/zone//"

  domain                = "seanlingren.com"
  cloudflare_account_id = data.cloudflare_account.account.account_id

  google_site_verifications = [
    "google-site-verification=cAtcJ0TFUenT4kLGmWnXh_4upiQTPYBnAYik_g_xtMU", # https://search.google.com/search-console/welcome
  ]
}

resource "cloudflare_dns_record" "seanlingren_com" {
  zone_id = module.zone_seanlingren_com.id
  proxied = true
  name    = "seanlingren.com"
  type    = "CNAME"
  ttl     = 1
  content = "lingrino.com" # superseded by below redirect
}

resource "cloudflare_dns_record" "star_seanlingren_com" {
  zone_id = module.zone_seanlingren_com.id
  proxied = true
  name    = "*.seanlingren.com"
  type    = "CNAME"
  ttl     = 1
  content = "lingrino.com" # superseded by below redirect
}

resource "cloudflare_ruleset" "redirect_seanlingren_com_to_lingrino_com" {
  zone_id = module.zone_seanlingren_com.id

  name        = "redirect"
  description = "redirect [*.]seanlingren.com to lingrino.com"

  kind  = "zone"
  phase = "http_request_dynamic_redirect"

  rules = [
    {
      action      = "redirect"
      description = "redirect [*.]seanlingren.com to lingrino.com"
      expression  = "true"

      action_parameters = {
        from_value = {
          status_code = 307
          target_url = {
            value = "https://lingrino.com"
          }
        }
      }
    }
  ]
}

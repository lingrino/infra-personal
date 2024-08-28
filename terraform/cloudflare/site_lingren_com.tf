module "zone_lingren_com" {
  source = "../../terraform-modules/zone//"

  domain                = "lingren.com"
  cloudflare_account_id = cloudflare_account.account.id

  enable_gsuite     = true
  gsuite_dkim_value = "v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAgHnP3rcpXx9kS2EVNQrxx9RX6+XDzyp520TlCkJE4MY1V7x8gX3xbe+nlZqdxKy79QbP3ZOf98+J5tw0wjGJIVucpBLr1nqN/N7hfyn5hSx+K4dQ2YjpS0LBvkWhRiegGeJas5UUba4Hlk0ZFfmcotjapKmSYtt1ZMfjareHo6nvCrPSrhbe19CVqgifXSi2JGFVj2sHweZWWEgsKpqSl6//XkYAm0kFseeGtWvKQGN5n03aYwHZQqg8x2evVmRTMfPYlE7cZxvjf0QItykAj6LCpB7l52WoBszJGGJ1E3NFWByXih4M2a0RFLZAkEVKGEcIwja5nrs6rkZNGQiDDQIDAQAB"

  google_site_verifications = [
    "google-site-verification=a0-Z4NWqKxxOU7qkFlNCsg1V_GgZFIzODQSkSI4jL7o", # https://admin.google.com
    "google-site-verification=_AknlqaZqFV-iSpS7EkWHIcT_zmqN23Sr4WTX5KZLew", # https://search.google.com/search-console/welcome
  ]
}

resource "cloudflare_record" "star_lingren_com" {
  zone_id = module.zone_lingren_com.id
  proxied = true
  name    = "*.lingren.com"
  type    = "CNAME"
  content = "lingrino.com" # superseded by below redirect
}

resource "cloudflare_ruleset" "redirect_lingren_com_to_lingrino_com" {
  zone_id = module.zone_lingren_com.id

  name        = "redirect"
  description = "redirect *.lingren.com to lingrino.com"

  kind  = "zone"
  phase = "http_request_dynamic_redirect"

  rules {
    action      = "redirect"
    description = "redirect *.lingren.com to lingrino.com"
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

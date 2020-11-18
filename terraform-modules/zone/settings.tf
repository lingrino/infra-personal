resource "cloudflare_argo" "argo" {
  count = var.enable_argo ? 1 : 0

  zone_id        = cloudflare_zone.zone.id
  tiered_caching = "on"
  smart_routing  = "on"
}

resource "cloudflare_zone_settings_override" "zone" {
  zone_id = cloudflare_zone.zone.id
  settings {
    always_online    = "on"
    browser_check    = "on"
    development_mode = "off"

    zero_rtt      = "on"
    rocket_loader = var.enable_caching ? "on" : "off"

    max_upload          = 100
    ip_geolocation      = "on"
    hotlink_protection  = "off"
    server_side_exclude = "on"

    challenge_ttl            = 1800
    privacy_pass             = "on"
    security_level           = "medium"
    email_obfuscation        = "on"
    opportunistic_onion      = "on"
    opportunistic_encryption = "on"

    ipv6              = "on"
    http3             = "on"
    websockets        = "on"
    pseudo_ipv4       = "off"
    h2_prioritization = "on"

    ssl             = "full"
    universal_ssl   = "on"
    tls_client_auth = "on"
    min_tls_version = "1.2"

    always_use_https         = "on"
    automatic_https_rewrites = "on"
    security_header {
      enabled            = true
      preload            = true
      include_subdomains = true
      max_age            = 31536000 # 1 year
    }

    brotli            = "on"
    cache_level       = "aggressive"
    browser_cache_ttl = 14400
    minify {
      css  = "on"
      js   = "on"
      html = "on"
    }
  }
}

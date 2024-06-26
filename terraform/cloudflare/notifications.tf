resource "cloudflare_notification_policy" "origin_availability" {
  account_id = cloudflare_account.account.id

  enabled    = true
  alert_type = "real_origin_monitoring"

  name        = "Origin Availability"
  description = "a cloudflare origin is detected as down"

  email_integration {
    id = "sean@lingren.com"
  }
}

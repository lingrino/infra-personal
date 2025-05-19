resource "cloudflare_notification_policy" "origin_availability" {
  account_id = data.cloudflare_account.account.account_id

  enabled    = true
  alert_type = "real_origin_monitoring"

  name        = "Origin Availability"
  description = "a cloudflare origin is detected as down"

  filters = {}

  mechanisms = {
    email = [{
      id = "sean@lingren.com"
    }]
  }
}

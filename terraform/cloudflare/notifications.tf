resource "cloudflare_notification_policy" "argo_high_traffic" {
  account_id = var.cloudflare_account_id

  enabled    = true
  alert_type = "billing_usage_alert"

  name        = "Argo - High Traffic"
  description = "Argo traffic exceeds 1GB traffic"

  email_integration {
    id = "sean@lingrino.com"
  }
}

resource "cloudflare_notification_policy" "workers_high_requests" {
  account_id = var.cloudflare_account_id

  enabled    = true
  alert_type = "billing_usage_alert"

  name        = "Workers - High Requests"
  description = "Workers traffic exceeds 5M requests"

  email_integration {
    id = "sean@lingrino.com"
  }
}

resource "cloudflare_notification_policy" "origin_availability" {
  account_id = var.cloudflare_account_id

  enabled    = true
  alert_type = "real_origin_monitoring"

  name        = "Origin - Availability"
  description = "A cloudflare origin is detected as down"

  email_integration {
    id = "sean@lingrino.com"
  }
}

resource "tailscale_tailnet_settings" "tailnet" {
  users_approval_on                           = false
  users_role_allowed_to_join_external_tailnet = "admin"

  devices_approval_on       = false
  devices_auto_updates_on   = true
  devices_key_duration_days = 180

  posture_identity_collection_on = true
}

resource "tailscale_contacts" "contacts" {
  account {
    email = "sean@lingren.com"
  }

  security {
    email = "sean@lingren.com"
  }

  support {
    email = "sean@lingren.com"
  }
}

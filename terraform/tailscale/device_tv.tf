data "tailscale_device" "tv" {
  name = "tv.bunny-morray.ts.net"
}

resource "tailscale_device_authorization" "tv" {
  device_id  = data.tailscale_device.tv.id
  authorized = true
}

resource "tailscale_device_key" "tv" {
  device_id           = data.tailscale_device.tv.id
  key_expiry_disabled = true
}

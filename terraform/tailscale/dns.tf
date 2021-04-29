resource "tailscale_dns_preferences" "prefs" {
  magic_dns = true
}

resource "tailscale_dns_nameservers" "ns" {
  nameservers = [
    "1.1.1.1",
    "1.0.0.1",
    "2606:4700:4700::1111",
    "2606:4700:4700::1001",
  ]
}

resource "tailscale_dns_search_paths" "sp" {
  search_paths = [
    "lingrino.dev",
  ]
}

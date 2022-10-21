resource "tailscale_dns_preferences" "prefs" {
  magic_dns = true
}

resource "tailscale_dns_nameservers" "ns" {
  nameservers = ["2a07:a8c0::59:7766"] # my nextdns
}

resource "tailscale_dns_search_paths" "sp" {
  search_paths = []
}

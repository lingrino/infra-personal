resource "digitalocean_vpc" "main_sfo3" {
  name     = "main-sfo3"
  region   = "sfo3"
  ip_range = "10.10.0.0/16"
}

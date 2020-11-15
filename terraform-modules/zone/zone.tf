resource "cloudflare_zone" "zone" {
  zone = var.domain
}

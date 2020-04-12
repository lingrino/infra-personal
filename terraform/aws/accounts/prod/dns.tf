locals {
  hostnames_pi = [
    "pi.lingrino.dev",
    "home.lingrino.dev",
  ]
  hostnames_adguard = [
    "ad.lingrino.dev",
    "adg.lingrino.dev",
    "adguard.lingrino.dev",
  ]
  hostnames_traefik = [
    "lb.lingrino.dev",
    "traefik.lingrino.dev",
  ]
}

data "aws_route53_zone" "lingrino_dev" {
  name = "lingrino.dev"
}

# Hostnames for tailscale devices
resource "aws_route53_record" "pi_lingrino_dev" {
  for_each = toset(concat(local.hostnames_pi, local.hostnames_adguard, local.hostnames_traefik))

  zone_id = data.aws_route53_zone.lingrino_dev.zone_id
  name    = each.key
  type    = "A"
  ttl     = 300
  records = ["100.73.130.78"]
}

resource "aws_route53_record" "phone_lingrino_dev" {
  zone_id = data.aws_route53_zone.lingrino_dev.zone_id
  name    = "phone.lingrino.dev."
  type    = "A"
  ttl     = 300
  records = ["100.123.188.98"]
}

resource "aws_route53_record" "ipad_lingrino_dev" {
  zone_id = data.aws_route53_zone.lingrino_dev.zone_id
  name    = "ipad.lingrino.dev."
  type    = "A"
  ttl     = 300
  records = ["100.127.107.107"]
}

resource "aws_route53_record" "work_lingrino_dev" {
  zone_id = data.aws_route53_zone.lingrino_dev.zone_id
  name    = "work.lingrino.dev."
  type    = "A"
  ttl     = 300
  records = ["100.92.251.90"]
}

resource "aws_route53_record" "mac_lingrino_dev" {
  zone_id = data.aws_route53_zone.lingrino_dev.zone_id
  name    = "mac.lingrino.dev."
  type    = "A"
  ttl     = 300
  records = ["100.91.40.80"]
}

# Hostnames for tailscale devices
resource "aws_route53_record" "pi_lingrino_dev" {
  zone_id = module.zone_lingrino_dev.zone_id
  name    = "pi.lingrino.dev."
  type    = "A"
  ttl     = 300
  records = ["100.73.130.78"]
}

resource "aws_route53_record" "adguard_lingrino_dev" {
  zone_id = module.zone_lingrino_dev.zone_id
  name    = "adguard.lingrino.dev."
  type    = "A"
  ttl     = 300
  records = ["100.73.130.78"]
}

resource "aws_route53_record" "phone_lingrino_dev" {
  zone_id = module.zone_lingrino_dev.zone_id
  name    = "phone.lingrino.dev."
  type    = "A"
  ttl     = 300
  records = ["100.123.188.98"]
}

resource "aws_route53_record" "work_lingrino_dev" {
  zone_id = module.zone_lingrino_dev.zone_id
  name    = "work.lingrino.dev."
  type    = "A"
  ttl     = 300
  records = ["100.92.251.90"]
}

resource "aws_route53_record" "mac_lingrino_dev" {
  zone_id = module.zone_lingrino_dev.zone_id
  name    = "mac.lingrino.dev."
  type    = "A"
  ttl     = 300
  records = ["100.92.251.90"]
}

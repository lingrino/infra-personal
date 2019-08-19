# https://www.fastmail.com/help/receive/domains-setup-mxonly.html
# https://www.fastmail.com/help/receive/domains-advanced.html
# https://www.fastmail.com/help/technical/senderauthentication.html

resource "aws_route53_record" "mx_verification" {
  count = var.enable_fastmail != "" ? 1 : 0

  zone_id = aws_route53_zone.zone.zone_id
  name    = var.domain
  type    = "MX"
  ttl     = 3600
  records = [
    "10 in1-smtp.messagingengine.com",
    "20 in2-smtp.messagingengine.com"
  ]
}

resource "aws_route53_record" "dkim_verification" {
  count = var.enable_fastmail != "" ? 3 : 0

  zone_id = aws_route53_zone.zone.zone_id
  name    = "fm${count.index}._domainkey.${var.domain}"
  type    = "CNAME"
  ttl     = 3600
  records = ["fm${count.index}.${var.domain}.dkim.fmhosted.com"]
}

resource "aws_route53_record" "webmail" {
  count = var.enable_fastmail && var.enable_fastmail_webmail_login_portal ? 1 : 0

  zone_id = aws_route53_zone.zone.zone_id
  name    = "mail.${var.domain}"
  type    = "A"
  ttl     = 3600
  records = [
    "66.111.4.147",
    "66.111.4.148"
  ]
}

resource "aws_route53_record" "client_email_autodiscovery_submission" {
  count = var.enable_fastmail != "" ? 1 : 0

  zone_id = aws_route53_zone.zone.zone_id
  name    = "_submission._tcp.${var.domain}"
  type    = "SRV"
  ttl     = 3600
  records = ["0 1 587 smtp.fastmail.com"]
}

resource "aws_route53_record" "client_email_autodiscovery_imap" {
  count = var.enable_fastmail != "" ? 1 : 0

  zone_id = aws_route53_zone.zone.zone_id
  name    = "_imap._tcp.${var.domain}"
  type    = "SRV"
  ttl     = 3600
  records = ["0 0 0 ."]
}

resource "aws_route53_record" "client_email_autodiscovery_imaps" {
  count = var.enable_fastmail != "" ? 1 : 0

  zone_id = aws_route53_zone.zone.zone_id
  name    = "_imaps._tcp.${var.domain}"
  type    = "SRV"
  ttl     = 3600
  records = ["0 1 993 imap.fastmail.com"]
}

resource "aws_route53_record" "client_email_autodiscovery_pop3" {
  count = var.enable_fastmail != "" ? 1 : 0

  zone_id = aws_route53_zone.zone.zone_id
  name    = "_pop3._tcp.${var.domain}"
  type    = "SRV"
  ttl     = 3600
  records = ["0 0 0 ."]
}

resource "aws_route53_record" "client_email_autodiscovery_pop3s" {
  zone_id = aws_route53_zone.zone.zone_id
  name    = "_pop3s._tcp.${var.domain}"
  type    = "SRV"
  ttl     = 3600
  records = ["10 1 995 pop.fastmail.com"]
}

resource "aws_route53_record" "client_carddav_autodiscovery" {
  count = var.enable_fastmail != "" ? 1 : 0

  zone_id = aws_route53_zone.zone.zone_id
  name    = "_carddav._tcp.${var.domain}"
  type    = "SRV"
  ttl     = 3600
  records = ["0 0 0 ."]
}

resource "aws_route53_record" "client_carddavs_autodiscovery" {
  count = var.enable_fastmail != "" ? 1 : 0

  zone_id = aws_route53_zone.zone.zone_id
  name    = "_carddavs._tcp.${var.domain}"
  type    = "SRV"
  ttl     = 3600
  records = ["0 1 443 carddav.fastmail.com"]
}

resource "aws_route53_record" "client_caldav_autodiscovery" {
  count = var.enable_fastmail != "" ? 1 : 0

  zone_id = aws_route53_zone.zone.zone_id
  name    = "_caldav._tcp.${var.domain}"
  type    = "SRV"
  ttl     = 3600
  records = ["0 0 0 ."]
}

resource "aws_route53_record" "client_caldavs_autodiscovery" {
  count = var.enable_fastmail != "" ? 1 : 0

  zone_id = aws_route53_zone.zone.zone_id
  name    = "_caldavs._tcp.${var.domain}"
  type    = "SRV"
  ttl     = 3600
  records = ["0 1 443 caldav.fastmail.com"]
}

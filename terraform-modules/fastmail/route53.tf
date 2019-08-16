resource "aws_route53_record" "mx_verification" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = var.domain_name
  type    = "MX"
  ttl     = 3600
  records = [
    "10 in1-smtp.messagingengine.com",
    "20 in2-smtp.messagingengine.com"
  ]
}

resource "aws_route53_record" "dkim_verification" {
  count = 3

  zone_id = data.aws_route53_zone.zone.zone_id
  name    = "fm${count.index}._domainkey.${var.domain_name}"
  type    = "CNAME"
  ttl     = 3600
  records = ["fm${count.index}.${var.domain_name}.dkim.fmhosted.com"]
}

resource "aws_route53_record" "spf_verification" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = var.domain_name
  type    = "TXT"
  ttl     = 3600
  records = ["v=spf1 include:spf.messagingengine.com ?all"]
}

resource "aws_route53_record" "webmail" {
  count = var.enable_webmail_login_portal ? 1 : 0

  zone_id = data.aws_route53_zone.zone.zone_id
  name    = "mail.${var.domain_name}"
  type    = "A"
  ttl     = 3600
  records = [
    "66.111.4.147",
    "66.111.4.148"
  ]
}

resource "aws_route53_record" "client_email_autodiscovery_submission" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = "_submission._tcp.${var.domain_name}"
  type    = "SRV"
  ttl     = 3600
  records = ["0 1 587 smtp.fastmail.com"]
}

resource "aws_route53_record" "client_email_autodiscovery_imap" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = "_imap._tcp.${var.domain_name}"
  type    = "SRV"
  ttl     = 3600
  records = ["0 0 0 ."]
}

resource "aws_route53_record" "client_email_autodiscovery_imaps" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = "_imaps._tcp.${var.domain_name}"
  type    = "SRV"
  ttl     = 3600
  records = ["0 1 993 imap.fastmail.com"]
}

resource "aws_route53_record" "client_email_autodiscovery_pop3" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = "_pop3._tcp.${var.domain_name}"
  type    = "SRV"
  ttl     = 3600
  records = ["0 0 0 ."]
}

resource "aws_route53_record" "client_email_autodiscovery_pop3s" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = "_pop3s._tcp.${var.domain_name}"
  type    = "SRV"
  ttl     = 3600
  records = ["10 1 995 pop.fastmail.com"]
}

resource "aws_route53_record" "client_carddav_autodiscovery" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = "_carddav._tcp.${var.domain_name}"
  type    = "SRV"
  ttl     = 3600
  records = ["0 0 0 ."]
}

resource "aws_route53_record" "client_carddavs_autodiscovery" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = "_carddavs._tcp.${var.domain_name}"
  type    = "SRV"
  ttl     = 3600
  records = ["0 1 443 carddav.fastmail.com"]
}

resource "aws_route53_record" "client_caldav_autodiscovery" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = "_caldav._tcp.${var.domain_name}"
  type    = "SRV"
  ttl     = 3600
  records = ["0 0 0 ."]
}

resource "aws_route53_record" "client_caldavs_autodiscovery" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = "_caldavs._tcp.${var.domain_name}"
  type    = "SRV"
  ttl     = 3600
  records = ["0 1 443 caldav.fastmail.com"]
}

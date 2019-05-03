# https://support.google.com/domains/answer/3251241?hl=en
resource "aws_route53_record" "mx_google_email" {
  count = "${ var.configure_google_domains_email_forwarding ? 1 : 0 }"

  zone_id = "${ aws_route53_zone.zone.zone_id }"
  name    = "${ var.domain }"
  type    = "MX"
  ttl     = 3600

  records = [
    "5 GMR-SMTP-IN.L.GOOGLE.COM.",
    "10 ALT1.GMR-SMTP-IN.L.GOOGLE.COM.",
    "20 ALT2.GMR-SMTP-IN.L.GOOGLE.COM.",
    "30 ALT3.GMR-SMTP-IN.L.GOOGLE.COM.",
    "40 ALT4.GMR-SMTP-IN.L.GOOGLE.COM.",
  ]
}

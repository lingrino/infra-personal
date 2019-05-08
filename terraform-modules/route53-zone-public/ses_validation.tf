locals {
  ses_notification_types = ["Bounce", "Complaint", "Delivery"]
}

resource "aws_ses_domain_identity" "ses" {
  count = "${ var.verify_ses ? 1 : 0 }"

  domain = "${ var.domain }"
}

resource "aws_ses_domain_mail_from" "ses" {
  count = "${ var.verify_ses ? 1 : 0 }"

  domain                 = "${ aws_ses_domain_identity.ses.domain }"
  mail_from_domain       = "bounce.${ aws_ses_domain_identity.ses.domain }"
  behavior_on_mx_failure = "RejectMessage"
}

resource "aws_ses_domain_dkim" "ses" {
  count = "${ var.verify_ses ? 1 : 0 }"

  domain = "${ aws_ses_domain_identity.ses.domain }"
}

resource "aws_ses_identity_notification_topic" "topics" {
  count = "${ var.verify_ses ? length(local.ses_notification_types) : 0 }"

  topic_arn         = "${ var.ses_sns_arn }"
  notification_type = "${ local.ses_notification_types[count.index] }"
  identity          = "${ aws_ses_domain_identity.ses.domain }"
}

resource "aws_ses_domain_identity_verification" "ses" {
  domain = "${ aws_ses_domain_identity.ses.id }"

  depends_on = ["aws_route53_record.ses_txt_verification"]
}

resource "aws_route53_record" "ses_txt_verification" {
  count = "${ var.verify_ses ? 1 : 0 }"

  zone_id = "${ aws_route53_zone.zone.id }"
  name    = "_amazonses.${ aws_ses_domain_identity.ses.domain }"
  type    = "TXT"
  ttl     = 3600
  records = ["${ aws_ses_domain_identity.ses.verification_token }"]
}

resource "aws_route53_record" "ses_dkim_verification" {
  count = "${ var.verify_ses ? 3 : 0 }"

  zone_id = "${ aws_route53_zone.zone.id }"
  name    = "${ element( aws_ses_domain_dkim.ses.dkim_tokens, count.index ) }._domainkey.${ aws_ses_domain_identity.ses.domain }"
  type    = "CNAME"
  ttl     = 3600
  records = ["${ element( aws_ses_domain_dkim.ses.dkim_tokens, count.index ) }.dkim.amazonses.com"]
}

resource "aws_route53_record" "ses_mailfrom_mx_verification" {
  count = "${ var.verify_ses ? 1 : 0 }"

  zone_id = "${ aws_route53_zone.zone.id }"
  name    = "${ aws_ses_domain_mail_from.ses.mail_from_domain }"
  type    = "MX"
  ttl     = 3600
  records = ["10 feedback-smtp.${ var.ses_region }.amazonses.com"]
}

resource "aws_route53_record" "ses_mailfrom_spf_verification" {
  count = "${ var.verify_ses ? 1 : 0 }"

  zone_id = "${ aws_route53_zone.zone.id }"
  name    = "${ aws_ses_domain_mail_from.ses.mail_from_domain }"
  type    = "TXT"
  ttl     = 3600
  records = ["v=spf1 include:amazonses.com -all"]
}

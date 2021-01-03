resource "cloudflare_record" "ses_txt_verification" {
  zone_id = var.zone_id
  name    = "_amazonses.${aws_ses_domain_identity.ses.domain}"
  type    = "TXT"
  value   = aws_ses_domain_identity.ses.verification_token
}

resource "cloudflare_record" "ses_dkim_verification" {
  for_each = toset(aws_ses_domain_dkim.ses.dkim_tokens)

  zone_id = var.zone_id
  name    = "${each.value}._domainkey.${aws_ses_domain_identity.ses.domain}"
  type    = "CNAME"
  value   = "${each.value}.dkim.amazonses.com"
}

resource "cloudflare_record" "ses_mailfrom_mx_verification" {
  zone_id  = var.zone_id
  name     = aws_ses_domain_mail_from.ses.mail_from_domain
  type     = "MX"
  priority = 10
  value    = "feedback-smtp.${var.ses_region}.amazonses.com"
}

resource "cloudflare_record" "ses_mailfrom_spf_verification" {
  zone_id = var.zone_id
  name    = aws_ses_domain_mail_from.ses.mail_from_domain
  type    = "TXT"
  value   = "v=spf1 include:amazonses.com -all"
}

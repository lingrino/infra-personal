locals {
  ses_notification_types = ["Bounce", "Complaint"]
}

resource "aws_ses_domain_identity" "ses" {
  domain = var.domain
}

resource "aws_ses_domain_mail_from" "ses" {
  domain                 = aws_ses_domain_identity.ses.domain
  mail_from_domain       = "bounce.${aws_ses_domain_identity.ses.domain}"
  behavior_on_mx_failure = "RejectMessage"
}

resource "aws_ses_domain_dkim" "ses" {
  domain = aws_ses_domain_identity.ses.domain
}

resource "aws_ses_identity_notification_topic" "topics" {
  for_each = toset(local.ses_notification_types)

  topic_arn         = var.ses_sns_arn
  notification_type = each.value
  identity          = aws_ses_domain_identity.ses.domain

  depends_on = [aws_ses_domain_identity_verification.ses]
}

resource "aws_ses_domain_identity_verification" "ses" {
  domain = aws_ses_domain_identity.ses.id

  depends_on = [cloudflare_record.ses_txt_verification]
}

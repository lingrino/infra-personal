locals {
  ses_notification_types = ["Bounce", "Complaint"]
}

resource "aws_ses_domain_identity" "ses" {
  provider = aws.ses

  domain = var.domain_name
}

resource "aws_ses_domain_mail_from" "ses" {
  provider = aws.ses

  domain                 = aws_ses_domain_identity.ses.domain
  mail_from_domain       = "bounce.${aws_ses_domain_identity.ses.domain}"
  behavior_on_mx_failure = "RejectMessage"
}

resource "aws_ses_domain_dkim" "ses" {
  provider = aws.ses

  domain = aws_ses_domain_identity.ses.domain
}

resource "aws_ses_identity_notification_topic" "topics" {
  provider = aws.ses
  count    = length(local.ses_notification_types)

  topic_arn         = var.ses_sns_arn
  notification_type = local.ses_notification_types[count.index]
  identity          = aws_ses_domain_identity.ses.domain

  depends_on = [aws_ses_domain_identity_verification.ses]
}

resource "aws_ses_domain_identity_verification" "ses" {
  provider = aws.ses

  domain = aws_ses_domain_identity.ses.id

  depends_on = [aws_route53_record.ses_txt_verification]
}

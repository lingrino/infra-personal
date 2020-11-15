locals {
  ses_notification_types = ["Bounce", "Complaint"]
}

resource "aws_ses_domain_identity" "ses" {
  count = var.verify_ses ? 1 : 0

  domain = var.domain
}

resource "aws_ses_domain_mail_from" "ses" {
  for_each = {
    for i in range(length(aws_ses_domain_identity.ses[*])) :
    i => {
      di = aws_ses_domain_identity.ses[i]
    }
  }

  domain                 = each.value.di.domain
  mail_from_domain       = "bounce.${each.value.di.domain}"
  behavior_on_mx_failure = "RejectMessage"
}

resource "aws_ses_domain_dkim" "ses" {
  for_each = {
    for i in range(length(aws_ses_domain_identity.ses[*])) :
    i => {
      di = aws_ses_domain_identity.ses[i]
    }
  }

  domain = each.value.di.domain
}

locals {
  ses_topics = setproduct(aws_ses_domain_identity.ses[*].domain, local.ses_notification_types)
}

resource "aws_ses_identity_notification_topic" "topics" {
  for_each = {
    for i in range(length(local.ses_topics)) :
    i => {
      domain = local.ses_topics[i][0]
      type   = local.ses_topics[i][1]
    }
  }

  topic_arn         = var.ses_sns_arn
  identity          = each.value.domain
  notification_type = each.value.type
}

resource "aws_ses_domain_identity_verification" "ses" {
  for_each = {
    for i in range(length(aws_ses_domain_identity.ses[*])) :
    i => {
      di = aws_ses_domain_identity.ses[i]
    }
  }

  domain = each.value.di.id

  depends_on = [cloudflare_record.ses_txt_verification]
}

resource "cloudflare_record" "ses_txt_verification" {
  for_each = {
    for i in range(length(aws_ses_domain_identity.ses[*])) :
    i => {
      di = aws_ses_domain_identity.ses[i]
    }
  }

  zone_id = cloudflare_zone.zone.id
  name    = "_amazonses.${each.value.di.domain}"
  type    = "TXT"
  value   = each.value.di.verification_token
}

locals {
  dkim_tokens = setproduct(
    aws_ses_domain_identity.ses[*].domain,
    [for t in flatten([for d in aws_ses_domain_dkim.ses : d.dkim_tokens]) : t]
  )
}

resource "cloudflare_record" "ses_dkim_verification" {
  for_each = {
    for i in range(length(local.dkim_tokens)) :
    i => {
      domain     = local.dkim_tokens[i][0]
      dkim_token = local.dkim_tokens[i][1]
    }
  }

  zone_id = cloudflare_zone.zone.id
  name    = "${each.value.dkim_token}._domainkey.${each.value.domain}"
  type    = "CNAME"
  value   = "${each.value.dkim_token}.dkim.amazonses.com"
}

resource "cloudflare_record" "ses_mailfrom_mx_verification" {
  for_each = {
    for i in range(length(aws_ses_domain_mail_from.ses)) :
    i => {
      mf = aws_ses_domain_mail_from.ses[i]
    }
  }

  zone_id  = cloudflare_zone.zone.id
  name     = each.value.mf.mail_from_domain
  type     = "MX"
  priority = 10
  value    = "feedback-smtp.${var.ses_region}.amazonses.com"
}

resource "cloudflare_record" "ses_mailfrom_spf_verification" {
  for_each = {
    for i in range(length(aws_ses_domain_mail_from.ses)) :
    i => {
      mf = aws_ses_domain_mail_from.ses[i]
    }
  }

  zone_id = cloudflare_zone.zone.id
  name    = each.value.mf.mail_from_domain
  type    = "TXT"
  value   = "v=spf1 include:amazonses.com -all"
}

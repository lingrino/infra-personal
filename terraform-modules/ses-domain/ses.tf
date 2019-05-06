resource "aws_ses_domain_identity" "ses" {
  provider = "aws.ses"

  domain = "${ var.domain_name }"
}

resource "aws_ses_domain_mail_from" "ses" {
  provider = "aws.ses"

  domain                 = "${ aws_ses_domain_identity.ses.domain }"
  mail_from_domain       = "bounce.${ aws_ses_domain_identity.ses.domain }"
  behavior_on_mx_failure = "RejectMessage"
}

resource "aws_ses_domain_dkim" "ses" {
  provider = "aws.ses"

  domain = "${ aws_ses_domain_identity.ses.domain }"
}

resource "aws_ses_domain_identity_verification" "ses" {
  provider = "aws.ses"

  domain = "${ aws_ses_domain_identity.ses.id }"

  depends_on = ["aws_route53_record.ses_txt_verification"]
}

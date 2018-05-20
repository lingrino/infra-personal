resource "aws_ses_domain_identity" "churner_io" {
  domain = "churner.io"
}

resource "aws_ses_domain_dkim" "churner_io" {
  domain = "${ aws_ses_domain_identity.churner_io.domain }"
}

resource "aws_ses_domain_mail_from" "churner_io" {
  domain                 = "${ aws_ses_domain_identity.churner_io.domain }"
  mail_from_domain       = "email.${ aws_ses_domain_identity.churner_io.domain }"
  behavior_on_mx_failure = "RejectMessage"
}

resource "aws_ses_identity_notification_topic" "churner_io_bounces" {
  identity          = "${ aws_ses_domain_identity.churner_io.domain }"
  notification_type = "Bounce"
  topic_arn         = "${ data.terraform_remote_state.sns_us_east_1.topic_all_email_bounces_complaints_arn }"
}

resource "aws_ses_identity_notification_topic" "churner_io_complaints" {
  identity          = "${ aws_ses_domain_identity.churner_io.domain }"
  notification_type = "Complaint"
  topic_arn         = "${ data.terraform_remote_state.sns_us_east_1.topic_all_email_bounces_complaints_arn }"
}

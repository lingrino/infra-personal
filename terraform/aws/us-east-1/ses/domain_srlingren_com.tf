resource "aws_ses_domain_identity" "srlingren_com" {
  domain = "srlingren.com"
}

resource "aws_ses_domain_dkim" "srlingren_com" {
  domain = "${ aws_ses_domain_identity.srlingren_com.domain }"
}

resource "aws_ses_domain_mail_from" "srlingren_com" {
  domain                 = "${ aws_ses_domain_identity.srlingren_com.domain }"
  mail_from_domain       = "email.${ aws_ses_domain_identity.srlingren_com.domain }"
  behavior_on_mx_failure = "RejectMessage"
}

resource "aws_ses_identity_notification_topic" "srlingren_com_bounces" {
  identity          = "${ aws_ses_domain_identity.srlingren_com.domain }"
  notification_type = "Bounce"
  topic_arn         = "${ data.terraform_remote_state.sns_us_east_1.topic_all_email_bounces_complaints_arn }"
}

resource "aws_ses_identity_notification_topic" "srlingren_com_complaints" {
  identity          = "${ aws_ses_domain_identity.srlingren_com.domain }"
  notification_type = "Complaint"
  topic_arn         = "${ data.terraform_remote_state.sns_us_east_1.topic_all_email_bounces_complaints_arn }"
}

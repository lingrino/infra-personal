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

resource "aws_ses_receipt_rule_set" "srlingren_com" {
  rule_set_name = "rules_srlingren_com"
}

resource "aws_ses_receipt_rule" "srlingren_com" {
  name          = "rules_srlingren_com_all"
  rule_set_name = "${ aws_ses_receipt_rule_set.srlingren_com.rule_set_name }"
  enabled       = true
  scan_enabled  = true
  tls_policy    = "Require"

  recipients = [
    "srlingren.com",
    ".srlingren.com",
  ]

  s3_action {
    position          = 1
    bucket_name       = "${ data.terraform_remote_state.s3.bucket_emails_name }"
    kms_key_arn       = "${ data.terraform_remote_state.kms_us_east_1.key_main_arn }"
    object_key_prefix = "srlingren_com/all/"
  }

  sns_action {
    position  = 2
    topic_arn = "${ data.terraform_remote_state.sns_us_east_1.topic_email_received_at_srlingren_com_arn }"
  }
}

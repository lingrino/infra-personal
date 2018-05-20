resource "aws_ses_receipt_rule" "rule_srlingren_com" {
  name          = "rule_srlingren_com"
  rule_set_name = "${ aws_ses_receipt_rule_set.ruleset_main.rule_set_name }"
  after         = "${ aws_ses_receipt_rule.rule_churner_io.name }"           # Churner is #1
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

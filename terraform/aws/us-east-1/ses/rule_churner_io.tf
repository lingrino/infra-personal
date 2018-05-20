resource "aws_ses_receipt_rule" "rule_churner_io" {
  name          = "rule_churner_io"
  rule_set_name = "${ aws_ses_receipt_rule_set.ruleset_main.rule_set_name }"
  enabled       = true
  scan_enabled  = true
  tls_policy    = "Require"

  recipients = [
    "churner.io",
    ".churner.io",
  ]

  s3_action {
    position          = 1
    bucket_name       = "${ data.terraform_remote_state.s3.bucket_emails_name }"
    kms_key_arn       = "${ data.terraform_remote_state.kms_us_east_1.key_main_arn }"
    object_key_prefix = "churner_io/all/"
  }

  sns_action {
    position  = 2
    topic_arn = "${ data.terraform_remote_state.sns_us_east_1.topic_email_received_at_churner_io_arn }"
  }
}

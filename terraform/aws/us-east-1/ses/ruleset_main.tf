resource "aws_ses_active_receipt_rule_set" "main" {
  rule_set_name = "${ aws_ses_receipt_rule_set.ruleset_main.rule_set_name }"
}

resource "aws_ses_receipt_rule_set" "ruleset_main" {
  rule_set_name = "ruleset_main"
}

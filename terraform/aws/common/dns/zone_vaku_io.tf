module "zone_vaku_io" {
  source = "../../../../terraform-modules/route53-zone-public//"

  domain            = "vaku.io"
  delegation_set_id = aws_route53_delegation_set.lingrino_prod.id

  keybase_record_value = "keybase-site-verification=MCj8gnnw6xQz-RfOHNZuDY-oXMqOFTKcnjuOZFmSnQA"
  ses_sns_arn          = data.terraform_remote_state.account_audit.outputs.sns_alarm_low_priority_arn

  enable_fastmail                      = true
  enable_fastmail_webmail_login_portal = true

  tags = var.tags

  providers = {
    aws = aws.prod
  }
}

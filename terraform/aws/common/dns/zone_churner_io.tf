module "zone_churner_io" {
  source = "../../../../terraform-modules/route53-zone-public//"

  domain            = "churner.io"
  delegation_set_id = aws_route53_delegation_set.lingrino_prod.id

  keybase_record_value = "keybase-site-verification=flLaCz4pXRjj3B4s0VLT6o9DpJXnD_FFSH7Gbjmau3c"
  ses_sns_arn          = data.terraform_remote_state.account_audit.outputs.sns_alarm_low_priority_arn

  tags = var.tags

  providers = {
    aws = aws.prod
  }
}

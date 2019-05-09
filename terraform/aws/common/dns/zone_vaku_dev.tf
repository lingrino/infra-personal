module "zone_vaku_dev" {
  source = "../../../../terraform-modules/route53-zone-public//"

  domain            = "vaku.dev"
  delegation_set_id = aws_route53_delegation_set.lingrino_prod.id

  keybase_record_value = "keybase-site-verification=rErM6Ph75uLJbtGJuj6D9NsruOHOGWFRHh-5zFNc668"
  ses_sns_arn          = data.terraform_remote_state.account_audit.outputs.sns_alarm_low_priority_arn

  tags = var.tags

  providers = {
    aws = aws.prod
  }
}

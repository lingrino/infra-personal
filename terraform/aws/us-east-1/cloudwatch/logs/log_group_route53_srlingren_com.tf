resource "aws_cloudwatch_log_group" "route53_srlingren_com" {
  name              = "/aws/route53/srlingren_com"
  retention_in_days = 30
  kms_key_id        = "${ data.terraform_remote_state.kms_us_east_1.key_main_arn }"

  tags = "${ merge(
    map(
      "Name",
      "route53_srlingren_com"
    ),
    module.constants.tags_default )
  }"
}

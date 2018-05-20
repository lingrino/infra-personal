resource "aws_cloudwatch_log_group" "route53_churner_io" {
  name              = "/aws/route53/churner_io"
  retention_in_days = 30
  kms_key_id        = "${ data.terraform_remote_state.kms_us_east_1.key_main_arn }"

  tags = "${ merge(
    map(
      "Name",
      "route53_churner_io"
    ),
    module.constants.tags_default )
  }"
}

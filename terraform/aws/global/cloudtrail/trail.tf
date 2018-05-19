resource "aws_cloudtrail" "trail" {
  name = "main"

  is_multi_region_trail         = true
  include_global_service_events = true
  enable_log_file_validation    = true

  kms_key_id     = "${ data.terraform_remote_state.kms_us_east_2.key_main_arn }"
  s3_bucket_name = "${ data.terraform_remote_state.s3.bucket_logs_name }"
  s3_key_prefix  = "cloudtrail/main"

  event_selector {
    read_write_type           = "All"
    include_management_events = true
  }

  tags = "${ merge(
    map(
      "Name",
      "main"
    ),
    module.constants.tags_default )
  }"
}

resource "aws_cloudtrail" "organization" {
  name           = "lingrino"
  enable_logging = true

  s3_bucket_name = data.terraform_remote_state.account_audit.outputs.bucket_cloudtrail_name

  is_multi_region_trail         = true
  is_organization_trail         = true
  enable_log_file_validation    = true
  include_global_service_events = true

  tags = merge(
    { "Name" = "lingrino" },
    { "description" = "The cloudtrail for the entire lingrino organization" },
    { "service" = "cloudtrail" },
    var.tags
  )
}

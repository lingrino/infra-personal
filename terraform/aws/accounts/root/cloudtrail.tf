resource "aws_cloudtrail" "organization" {
  name           = "lingrino"
  enable_logging = true

  s3_bucket_name = "${ data.terraform_remote_state.account_audit.bucket_cloudtrail_name }"

  is_multi_region_trail         = true
  is_organization_trail         = true
  enable_log_file_validation    = true
  include_global_service_events = true

  tags = "${ merge(
    map("Name", "lingrino"),
    map("description", "The cloudtrail for the entire lingrino organization"),
    var.tags
  )}"
}

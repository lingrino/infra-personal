resource "aws_cloudtrail" "organization" {
  provider = aws.us-east-1

  name           = "main"
  enable_logging = true

  s3_bucket_name = data.terraform_remote_state.account_audit.outputs.bucket_cloudtrail_name

  is_multi_region_trail         = true
  is_organization_trail         = true
  enable_log_file_validation    = true
  include_global_service_events = true

  tags = {
    Name = "main"
  }
}

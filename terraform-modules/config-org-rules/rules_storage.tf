####################################
### EBS Usage                    ###
####################################
resource "aws_config_organization_managed_rule" "ebs_usage" {
  name        = "ebs_usage"
  description = "Noncompliant when EBS volumes are not attached to instances"

  rule_identifier = "EC2_VOLUME_INUSE_CHECK"

  tags = merge(
    { "Name" = "ebs_usage" },
    var.tags
  )
}

####################################
### EBS Encrypted                ###
####################################
resource "aws_config_organization_managed_rule" "ebs_encrypted" {
  name        = "ebs_encrypted"
  description = "Noncompliant when EBS volumes are not encrypted"

  rule_identifier = "ENCRYPTED_VOLUMES"

  tags = merge(
    { "Name" = "ebs_encrypted" },
    var.tags
  )
}

####################################
### EBS Optimization             ###
####################################
resource "aws_config_organization_managed_rule" "ebs_optimization" {
  name        = "ebs_optimization"
  description = "Noncompliant when EBS optimization is not enabled"

  rule_identifier = "EBS_OPTIMIZED_INSTANCE"

  tags = merge(
    { "Name" = "ebs_optimization" },
    var.tags
  )
}

####################################
### S3 SSL                       ###
####################################
resource "aws_config_organization_managed_rule" "s3_ssl" {
  name        = "s3_ssl"
  description = "Noncompliant when S3 buckets do not require access over ssl"

  rule_identifier = "S3_BUCKET_SSL_REQUESTS_ONLY"

  tags = merge(
    { "Name" = "s3_ssl" },
    var.tags
  )
}

####################################
### S3 Encrypted                 ###
####################################
resource "aws_config_organization_managed_rule" "s3_encrypted" {
  name        = "s3_encrypted"
  description = "Noncompliant when S3 buckets do not have SSE by default or a policy that requires SSE"

  rule_identifier = "S3_BUCKET_SERVER_SIDE_ENCRYPTION_ENABLED"

  tags = merge(
    { "Name" = "s3_encrypted" },
    var.tags
  )
}

####################################
### S3 Versioning                ###
####################################
resource "aws_config_organization_managed_rule" "s3_versioning" {
  name        = "s3_versioning"
  description = "Noncompliant when S3 buckets do not have versioning enabled"

  rule_identifier = "S3_BUCKET_VERSIONING_ENABLED"

  tags = merge(
    { "Name" = "s3_versioning" },
    var.tags
  )
}

####################################
### S3 Public Read               ###
####################################
resource "aws_config_organization_managed_rule" "s3_public_read" {
  name        = "s3_public_read"
  description = "Noncompliant when S3 buckets allow public read access"

  rule_identifier = "S3_BUCKET_PUBLIC_READ_PROHIBITED"

  tags = merge(
    { "Name" = "s3_public_read" },
    var.tags
  )
}

####################################
### S3 Public Write              ###
####################################
resource "aws_config_organization_managed_rule" "s3_public_write" {
  name        = "s3_public_write"
  description = "Noncompliant when S3 buckets allow public write access"

  rule_identifier = "S3_BUCKET_PUBLIC_WRITE_PROHIBITED"

  tags = merge(
    { "Name" = "s3_public_write" },
    var.tags
  )
}

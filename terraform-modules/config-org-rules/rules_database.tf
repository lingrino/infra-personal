####################################
### Dynamo Encrypted             ###
####################################
resource "aws_config_organization_managed_rule" "dynamo_encrypted" {
  name        = "dynamo_encrypted"
  description = "Noncompliant when DynamoDB tables are not encrypted"

  rule_identifier = "DYNAMODB_TABLE_ENCRYPTION_ENABLED"

  tags = merge(
    { "Name" = "dynamo_encrypted" },
    var.tags
  )
}

####################################
### RDS Encrypted                ###
####################################
resource "aws_config_organization_managed_rule" "rds_encrypted" {
  name        = "rds_encrypted"
  description = "Noncompliant when RDS databases are not encrypted"

  rule_identifier = "RDS_STORAGE_ENCRYPTED"

  tags = merge(
    { "Name" = "rds_encrypted" },
    var.tags
  )
}

####################################
### RDS Multi AZ                 ###
####################################
resource "aws_config_organization_managed_rule" "rds_multi_az" {
  name        = "rds_multi_az"
  description = "Noncompliant when RDS databases do not have multi az enabled"

  rule_identifier = "RDS_MULTI_AZ_SUPPORT"

  tags = merge(
    { "Name" = "rds_multi_az" },
    var.tags
  )
}

####################################
### RDS Public Access            ###
####################################
resource "aws_config_organization_managed_rule" "rds_public_access" {
  name        = "rds_public_access"
  description = "Noncompliant when RDS databases are accessible to the public"

  rule_identifier = "RDS_INSTANCE_PUBLIC_ACCESS_CHECK"

  tags = merge(
    { "Name" = "rds_public_access" },
    var.tags
  )
}

####################################
### RDS Backup                   ###
####################################
resource "aws_config_organization_managed_rule" "rds_backup" {
  name        = "rds_backup"
  description = "Noncompliant when RDS databases are not backed up"

  rule_identifier = "DB_INSTANCE_BACKUP_ENABLED"

  tags = merge(
    { "Name" = "rds_backup" },
    var.tags
  )
}

####################################
### RDS Public Snapshots         ###
####################################
resource "aws_config_organization_managed_rule" "rds_public_snapshots" {
  name        = "rds_public_snapshots"
  description = "Noncompliant when RDS snapshots are accessible to the public"

  rule_identifier = "RDS_INSTANCE_PUBLIC_ACCESS_CHECK"

  tags = merge(
    { "Name" = "rds_public_snapshots" },
    var.tags
  )
}

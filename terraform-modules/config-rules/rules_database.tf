####################################
### Dynamo Encrypted             ###
####################################
resource "aws_config_config_rule" "dynamo_encrypted" {
  name        = "dynamo_encrypted"
  description = "Noncompliant when DynamoDB tables are not encrypted"

  source {
    owner             = "AWS"
    source_identifier = "DYNAMODB_TABLE_ENCRYPTION_ENABLED"
  }
}

####################################
### RDS Encrypted                ###
####################################
resource "aws_config_config_rule" "rds_encrypted" {
  name        = "rds_encrypted"
  description = "Noncompliant when RDS databases are not encrypted"

  source {
    owner             = "AWS"
    source_identifier = "RDS_STORAGE_ENCRYPTED"
  }
}

####################################
### RDS Multi AZ                 ###
####################################
resource "aws_config_config_rule" "rds_multi_az" {
  name        = "rds_multi_az"
  description = "Noncompliant when RDS databases do not have multi az enabled"

  source {
    owner             = "AWS"
    source_identifier = "RDS_MULTI_AZ_SUPPORT"
  }
}

####################################
### RDS Public Access            ###
####################################
resource "aws_config_config_rule" "rds_public_access" {
  name        = "rds_public_access"
  description = "Noncompliant when RDS databases are accessible to the public"

  source {
    owner             = "AWS"
    source_identifier = "RDS_INSTANCE_PUBLIC_ACCESS_CHECK"
  }
}

####################################
### RDS Backup                   ###
####################################
resource "aws_config_config_rule" "rds_backup" {
  name        = "rds_backup"
  description = "Noncompliant when RDS databases are not backed up"

  source {
    owner             = "AWS"
    source_identifier = "DB_INSTANCE_BACKUP_ENABLED"
  }
}

####################################
### RDS Public Snapshots         ###
####################################
resource "aws_config_config_rule" "rds_public_snapshots" {
  name        = "rds_public_snapshots"
  description = "Noncompliant when RDS snapshots are accessible to the public"

  source {
    owner             = "AWS"
    source_identifier = "RDS_INSTANCE_PUBLIC_ACCESS_CHECK"
  }
}

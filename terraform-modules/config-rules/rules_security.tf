####################################
### ACM Expiration               ###
####################################
resource "aws_config_config_rule" "acm_expiration" {
  name        = "acm_expiration"
  description = "Noncompliant when ACM certificates are expiring in the next 14 days"

  source {
    owner             = "AWS"
    source_identifier = "ACM_CERTIFICATE_EXPIRATION_CHECK"
  }

  tags = merge(
    { "Name" = "acm_expiration" },
    var.tags
  )
}

####################################
### Cloudtrail Enabled           ###
####################################
resource "aws_config_config_rule" "cloudtrail_enabled" {
  name        = "cloudtrail_enabled"
  description = "Noncompliant when cloudtrail is disabled"

  source {
    owner             = "AWS"
    source_identifier = "CLOUD_TRAIL_ENABLED"
  }

  tags = merge(
    { "Name" = "cloudtrail_enabled" },
    var.tags
  )
}

####################################
### Cloudtrail Global Enabled    ###
####################################
resource "aws_config_config_rule" "cloudtrail_global_nabled" {
  name        = "cloudtrail_global_enabled"
  description = "Noncompliant when there is no enabled multi-region cloudtrail"

  source {
    owner             = "AWS"
    source_identifier = "MULTI_REGION_CLOUD_TRAIL_ENABLED"
  }

  tags = merge(
    { "Name" = "cloudtrail_global_enabled" },
    var.tags
  )
}

####################################
### Cloudtrail Encrypted         ###
####################################
resource "aws_config_config_rule" "cloudtrail_encrypted" {
  name        = "cloudtrail_encrypted"
  description = "Noncompliant when cloudtrail is not encrypted"

  source {
    owner             = "AWS"
    source_identifier = "CLOUD_TRAIL_ENCRYPTION_ENABLED"
  }

  tags = merge(
    { "Name" = "cloudtrail_encrypted" },
    var.tags
  )
}

####################################
### Cloudtrail File Validation   ###
####################################
resource "aws_config_config_rule" "cloudtrail_file_validation" {
  name        = "cloudtrail_file_validation"
  description = "Noncompliant when cloudtrail is not writing signed digest files with logs"

  source {
    owner             = "AWS"
    source_identifier = "CLOUD_TRAIL_LOG_FILE_VALIDATION_ENABLED"
  }

  tags = merge(
    { "Name" = "cloudtrail_file_validation" },
    var.tags
  )
}

####################################
### Cloudtrail to Cloudwatch     ###
####################################
resource "aws_config_config_rule" "cloudtrail_to_cloudwatch" {
  name        = "cloudtrail_to_cloudwatch"
  description = "Noncompliant when cloudtrail is not writing to cloudwatch"

  source {
    owner             = "AWS"
    source_identifier = "CLOUD_TRAIL_CLOUD_WATCH_LOGS_ENABLED"
  }

  tags = merge(
    { "Name" = "cloudtrail_to_cloudwatch" },
    var.tags
  )
}

####################################
### IAM Keys Rotated             ###
####################################
resource "aws_config_config_rule" "iam_keys_rotated" {
  name        = "iam_keys_rotated"
  description = "Noncompliant when iam access keys haven't been rotated in the last 90 days"

  source {
    owner             = "AWS"
    source_identifier = "ACCESS_KEYS_ROTATED"
  }

  tags = merge(
    { "Name" = "iam_keys_rotated" },
    var.tags
  )

  input_parameters = "{\"maxAccessKeyAge\": \"90\"}"
}

####################################
### IAM Root Keys                ###
####################################
resource "aws_config_config_rule" "iam_root_keys" {
  name        = "iam_root_keys"
  description = "Noncompliant when the root user has active AWS access keys"

  source {
    owner             = "AWS"
    source_identifier = "IAM_ROOT_ACCESS_KEY_CHECK"
  }

  tags = merge(
    { "Name" = "iam_root_keys" },
    var.tags
  )
}

####################################
### IAM Root MFA                 ###
####################################
resource "aws_config_config_rule" "iam_root_mfa" {
  name        = "iam_root_mfa"
  description = "Noncompliant when the root user does not have MFA enabled"

  source {
    owner             = "AWS"
    source_identifier = "ROOT_ACCOUNT_MFA_ENABLED"
  }

  tags = merge(
    { "Name" = "iam_root_mfa" },
    var.tags
  )
}

####################################
### IAM Console User MFA         ###
####################################
resource "aws_config_config_rule" "iam_console_user_mfa" {
  name        = "iam_console_user_mfa"
  description = "Noncompliant when an IAM user with console access does not have MFA enabled"

  source {
    owner             = "AWS"
    source_identifier = "MFA_ENABLED_FOR_IAM_CONSOLE_ACCESS"
  }

  tags = merge(
    { "Name" = "iam_console_user_mfa" },
    var.tags
  )
}

####################################
### IAM Unused User              ###
####################################
resource "aws_config_config_rule" "iam_unused_user" {
  name        = "iam_unused_user"
  description = "Noncompliant when an IAM users keys or password have not been used in the last 90 days"

  source {
    owner             = "AWS"
    source_identifier = "IAM_USER_UNUSED_CREDENTIALS_CHECK"
  }

  tags = merge(
    { "Name" = "iam_unused_user" },
    var.tags
  )

  input_parameters = "{\"maxCredentialUsageAge\": \"90\"}"
}

####################################
### IAM User Policies            ###
####################################
resource "aws_config_config_rule" "iam_user_policies" {
  name        = "iam_user_policies"
  description = "Noncompliant when an IAM user has policies attached directly"

  source {
    owner             = "AWS"
    source_identifier = "IAM_USER_NO_POLICIES_CHECK"
  }

  tags = merge(
    { "Name" = "iam_user_policies" },
    var.tags
  )
}

####################################
### IAM User in Group            ###
####################################
resource "aws_config_config_rule" "iam_user_in_group" {
  name        = "iam_user_in_group"
  description = "Noncompliant when an IAM user is not in at least one group"

  source {
    owner             = "AWS"
    source_identifier = "IAM_USER_GROUP_MEMBERSHIP_CHECK"
  }

  tags = merge(
    { "Name" = "iam_user_in_group" },
    var.tags
  )
}

resource "aws_backup_vault" "default" {
  name        = "default"
  kms_key_arn = "aws/backup"

  tags = merge(
    { "Name" = "default" },
    { "description" = "the default vault for our backups" },
    var.tags
  )
}

resource "aws_backup_plan" "default" {
  name = "default"

  rule {
    rule_name           = "default"
    target_vault_name   = aws_backup_vault.default.name
    schedule            = "cron(0 16 * * ? *)"
    recovery_point_tags = var.tags

    lifecycle {
      cold_storage_after = 30
      delete_after       = 120
    }
  }

  tags = merge(
    { "Name" = "default" },
    { "description" = "by default backup all resources with the tag 'backup: true'" },
    var.tags
  )
}

resource "aws_backup_selection" "default" {
  name         = "default"
  plan_id      = aws_backup_plan.default.id
  iam_role_arn = aws_iam_role.backup_default.arn

  selection_tag {
    type  = "STRINGEQUALS"
    key   = "backup"
    value = "true"
  }
}

resource "aws_iam_role" "backup_default" {
  name        = "aws-backup-default"
  description = "The role that AWS assumes to run our default backups"

  assume_role_policy    = data.aws_iam_policy_document.arp_backup_default.json
  force_detach_policies = true

  tags = merge(
    { "Name" = "aws-backup-default" },
    { "description" = "The role that AWS assumes to run our default backups" },
    var.tags
  )
}

data "aws_iam_policy_document" "arp_backup_default" {
  statement {
    sid = "BackupDefaultAssumeRole"

    principals {
      type        = "Service"
      identifiers = ["backup.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role_policy_attachment" "backup_default" {
  role       = aws_iam_role.backup_default.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
}

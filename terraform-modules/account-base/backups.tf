data "aws_kms_key" "backup" {
  key_id = "alias/aws/backup"
}

resource "aws_backup_vault" "tag_backup_true" {
  name        = "tag-backup-true"
  kms_key_arn = data.aws_kms_key.backup.arn

  tags = merge(
    { "Name" = "tag-backup-true" },
    { "description" = "the vault for all our backups where the resource is tagged backup: true" },
    var.tags
  )
}

resource "aws_backup_plan" "tag_backup_true" {
  name = "tag-backup-true"

  rule {
    rule_name         = "tag-backup-true"
    target_vault_name = aws_backup_vault.tag_backup_true.name
    schedule          = "cron(0 16 * * ? *)"

    recovery_point_tags = merge(
      { "terraform" = "true" },
      { "description" = "this resource was backed because it was tagged backup: true" },
      var.tags
    )

    lifecycle {
      cold_storage_after = 30
      delete_after       = 120
    }
  }

  tags = merge(
    { "Name" = "tag-backup-true" },
    { "description" = "backup all resources with the tag backup: true" },
    var.tags
  )
}

resource "aws_backup_selection" "tag_backup_true" {
  name         = "tag-backup-true"
  plan_id      = aws_backup_plan.tag_backup_true.id
  iam_role_arn = aws_iam_role.tag_backup_true.arn

  selection_tag {
    type  = "STRINGEQUALS"
    key   = "backup"
    value = "true"
  }
}

resource "aws_iam_role" "tag_backup_true" {
  name        = "aws-backup-tag-backup-true"
  description = "The role that AWS assumes to run our tag-backup-true backups"

  assume_role_policy    = data.aws_iam_policy_document.arp_tag_backup_true.json
  force_detach_policies = true

  tags = merge(
    { "Name" = "aws-backup-tag-backup-true" },
    { "description" = "The role that AWS assumes to run our tag-backup-true backups" },
    var.tags
  )
}

data "aws_iam_policy_document" "arp_tag_backup_true" {
  statement {
    sid = "AssumeFromBackupService"

    principals {
      type        = "Service"
      identifiers = ["backup.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role_policy_attachment" "tag_backup_true" {
  role       = aws_iam_role.tag_backup_true.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
}

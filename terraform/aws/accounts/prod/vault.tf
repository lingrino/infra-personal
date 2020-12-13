resource "aws_dynamodb_table" "vault" {
  name         = "vault"
  billing_mode = "PAY_PER_REQUEST"

  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

  hash_key  = "Path"
  range_key = "Key"

  attribute {
    name = "Path"
    type = "S"
  }
  attribute {
    name = "Key"
    type = "S"
  }

  replica {
    region_name = "us-west-2"
  }

  server_side_encryption {
    enabled = true
  }

  point_in_time_recovery {
    enabled = true
  }

  tags = merge(
    { "Name" = "vault" },
    var.tags,
  )
}

resource "aws_kms_alias" "vault" {
  name          = "alias/vault/unseal"
  target_key_id = aws_kms_key.vault.key_id
}

resource "aws_kms_key" "vault" {
  enable_key_rotation = true

  tags = merge(
    { "Name" = "vault/unseal" },
    { "description" = "KMS key used for vault auto unseal" },
    var.tags,
  )
}

resource "aws_iam_user" "vault" {
  name          = "vault"
  force_destroy = true

  tags = merge(
    { "Name" = "vault" },
    var.tags,
  )
}

resource "aws_iam_user_policy" "vault" {
  name_prefix = "vault-"
  user        = aws_iam_user.vault.id
  policy      = data.aws_iam_policy_document.vault.json
}

data "aws_iam_policy_document" "vault" {
  statement {
    effect = "Allow"

    actions = [
      "dynamodb:BatchGetItem",
      "dynamodb:BatchWriteItem",
      "dynamodb:DeleteItem",
      "dynamodb:DescribeLimits",
      "dynamodb:DescribeReservedCapacity",
      "dynamodb:DescribeReservedCapacityOfferings",
      "dynamodb:DescribeTable",
      "dynamodb:DescribeTimeToLive",
      "dynamodb:GetItem",
      "dynamodb:GetRecords",
      "dynamodb:ListTables",
      "dynamodb:ListTagsOfResource",
      "dynamodb:PutItem",
      "dynamodb:Query",
      "dynamodb:Scan",
      "dynamodb:UpdateItem",
    ]

    resources = [
      aws_dynamodb_table.vault.arn,
      "${aws_dynamodb_table.vault.arn}/*",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:DescribeKey",
    ]

    resources = [
      aws_kms_key.vault.arn,
    ]
  }
}

resource "aws_iam_access_key" "vault" {
  user = aws_iam_user.vault.name
}

output "vault_region" {
  description = "The AWS region that vault is deployed to"
  value       = "us-east-1"
}

output "vault_dynamo_name" {
  description = "The name of the vault dynamo table"
  value       = aws_dynamodb_table.vault.name
}

output "vault_kms_id" {
  description = "The ID of the KMS key used for vault auto unseal"
  value       = aws_kms_key.vault.key_id
}

output "vault_user_akid" {
  description = "The AWS Access Key ID of the vault user"
  value       = aws_iam_access_key.vault.id
}

output "vault_user_sak" {
  description = "The AWS Secret Access Key of the vault user"
  value       = aws_iam_access_key.vault.secret
  sensitive   = true
}

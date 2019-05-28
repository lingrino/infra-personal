resource "aws_dynamodb_table" "state" {
  count = var.create_lock_table ? 1 : 0

  name         = "TerraformRemoteStateLock"
  billing_mode = "PAY_PER_REQUEST"

  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  server_side_encryption {
    enabled = true
  }

  tags = merge(
    { "Name" = "TerraformRemoteStateLock" },
    var.tags
  )
}

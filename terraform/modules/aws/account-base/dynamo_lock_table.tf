resource "aws_dynamodb_table" "state" {
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

  tags = "${ merge(
    map("Name", "TerraformRemoteStateLock"),
    var.tags )
  }"
}

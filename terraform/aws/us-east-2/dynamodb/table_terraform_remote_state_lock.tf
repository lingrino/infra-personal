resource "aws_dynamodb_table" "terraform_remote_state_lock" {
  name           = "TerraformRemoteStateLock"
  read_capacity  = 2
  write_capacity = 2
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  server_side_encryption {
    enabled = true
  }

  tags = "${ merge(
    map(
      "Name",
      "TerraformRemoteStateLock"
    ),
    module.constants.tags_default )
  }"
}

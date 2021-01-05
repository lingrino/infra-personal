resource "aws_dynamodb_table" "vault" {
  name         = var.name_prefix
  billing_mode = "PAY_PER_REQUEST"

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

  server_side_encryption {
    enabled = true
  }

  point_in_time_recovery {
    enabled = true
  }

  tags = merge(
    { "Name" = var.name_prefix },
    var.tags,
  )
}

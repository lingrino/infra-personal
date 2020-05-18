resource "aws_dynamodb_table" "vault" {
  name         = var.name_prefix
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
    region_name = data.aws_region.current.name
  }

  replica {
    region_name = var.dr_region
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

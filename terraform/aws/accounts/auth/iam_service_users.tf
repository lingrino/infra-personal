resource "aws_iam_user" "atlantis" {
  name          = "atlantis"
  force_destroy = true

  tags = merge(
    { "Name" = "atlantis" },
    var.tags
  )
}

resource "aws_iam_access_key" "atlantis" {
  user = aws_iam_user.atlantis.name
}

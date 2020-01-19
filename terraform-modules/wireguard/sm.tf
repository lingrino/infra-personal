resource "aws_secretsmanager_secret" "wg" {
  name_prefix = "${var.name_prefix}-"

  tags = merge(
    { "Name" = var.name_prefix },
    { "description" = "holds the secret parts of the wireguard configuration" },
    var.tags,
  )
}

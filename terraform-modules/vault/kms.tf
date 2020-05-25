resource "aws_kms_alias" "vault" {
  name          = "alias/${var.name_prefix}/unseal"
  target_key_id = aws_kms_key.vault.key_id
}

resource "aws_kms_key" "vault" {
  enable_key_rotation = true

  tags = merge(
    { "Name" = "${var.name_prefix}/unseal" },
    { "description" = "KMS key used for vault auto unseal" },
    var.tags,
  )
}

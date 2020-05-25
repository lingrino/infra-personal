data "template_file" "vault_config" {
  template = file("${path.module}/files/config.hcl")

  vars = {
    name_prefix = var.name_prefix
    region      = data.aws_region.current.name

    kms_id           = aws_kms_key.vault.key_id
    domain_name      = var.domain_name
    vault_config_dir = var.vault_config_dir
    dynamo_name      = aws_dynamodb_table.vault.name
  }
}

resource "aws_s3_bucket_object" "config" {
  bucket                 = aws_s3_bucket.config.id
  key                    = "config.hcl"
  content_base64         = base64encode(data.template_file.vault_config.rendered)
  etag                   = md5(data.template_file.vault_config.rendered)
  server_side_encryption = "AES256"

  tags = merge(
    { "Name" = "config.hcl" },
    var.tags,
  )
}

resource "aws_s3_bucket_object" "crt" {
  bucket                 = aws_s3_bucket.config.id
  key                    = "crt.pem"
  content_base64         = base64encode(tls_locally_signed_cert.cert.cert_pem)
  etag                   = md5(tls_locally_signed_cert.cert.cert_pem)
  server_side_encryption = "AES256"

  tags = merge(
    { "Name" = "crt.pem" },
    var.tags,
  )
}

resource "aws_s3_bucket_object" "key" {
  bucket                 = aws_s3_bucket.config.id
  key                    = "key.pem"
  content_base64         = base64encode(tls_private_key.cert.private_key_pem)
  etag                   = md5(tls_private_key.cert.private_key_pem)
  server_side_encryption = "AES256"

  tags = merge(
    { "Name" = "key.pem" },
    var.tags,
  )
}

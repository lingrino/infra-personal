resource "aws_secretsmanager_secret" "backblaze_keys_arq_mini" {
  name = "backblaze/keys/arq-mini"

  tags = {
    Name = "backblaze/keys/arq-mini"
  }
}

resource "aws_secretsmanager_secret_version" "backblaze_keys_arq_mini" {
  secret_id = aws_secretsmanager_secret.backblaze_keys_arq_mini.id
  secret_string = jsonencode({
    B2_APPLICATION_KEY_ID = b2_application_key.arq_mini.application_key_id,
    B2_APPLICATION_KEY    = b2_application_key.arq_mini.application_key,
  })
}

resource "b2_application_key" "arq_mini" {
  key_name  = "arq-mini"
  bucket_id = b2_bucket.arq_mini.id

  capabilities = [
    "listBuckets",
    "readBuckets",
    "readBucketEncryption",
    "readBucketReplications",
    "readBucketRetentions",
    "listFiles",
    "readFiles",
    "shareFiles",
    "writeFiles",
    "deleteFiles",
    "readFileRetentions",
    "readFileLegalHolds",
  ]
}

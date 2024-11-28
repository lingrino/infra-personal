resource "aws_secretsmanager_secret" "backblaze_keys_terraform_cloud" {
  name = "backblaze/keys/terraform-cloud"

  tags = {
    Name = "backblaze/keys/terraform-cloud"
  }
}

ephemeral "aws_secretsmanager_secret_version" "backblaze_keys_terraform_cloud" {
  secret_id = aws_secretsmanager_secret.backblaze_keys_terraform_cloud.id
}

resource "aws_secretsmanager_secret_version" "backblaze_keys_terraform_cloud" {
  secret_id = aws_secretsmanager_secret.backblaze_keys_terraform_cloud.id
  secret_string = jsonencode({
    B2_APPLICATION_KEY_ID = b2_application_key.terraform_cloud.application_key_id,
    B2_APPLICATION_KEY    = b2_application_key.terraform_cloud.application_key,
  })
}

resource "b2_application_key" "terraform_cloud" {
  key_name = "terraform-cloud"
  capabilities = [
    "bypassGovernance",
    "listKeys",
    "writeKeys",
    "deleteKeys",
    "listAllBucketNames",
    "listBuckets",
    "readBuckets",
    "writeBuckets",
    "deleteBuckets",
    "readBucketEncryption",
    "readBucketReplications",
    "readBucketRetentions",
    "writeBucketEncryption",
    "writeBucketReplications",
    "writeBucketRetentions",
    "listFiles",
    "readFiles",
    "shareFiles",
    "writeFiles",
    "deleteFiles",
    "readFileRetentions",
    "readFileLegalHolds",
    "writeFileRetentions",
    "writeFileLegalHolds",
  ]
}

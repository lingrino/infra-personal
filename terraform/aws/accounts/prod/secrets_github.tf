resource "aws_secretsmanager_secret" "github_keys_terraform_cloud" {
  name = "github/keys/terraform-cloud"

  tags = {
    Name = "github/keys/terraform-cloud"
  }
}

data "aws_secretsmanager_secret_version" "github_keys_terraform_cloud" {
  secret_id = aws_secretsmanager_secret.github_keys_terraform_cloud.id
}

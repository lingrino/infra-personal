resource "aws_secretsmanager_secret" "tailscale_keys_terraform_cloud" {
  name = "tailscale/keys/terraform-cloud"

  tags = {
    Name = "tailscale/keys/terraform-cloud"
  }
}

data "aws_secretsmanager_secret_version" "tailscale_keys_terraform_cloud" {
  secret_id = aws_secretsmanager_secret.tailscale_keys_terraform_cloud.id
}

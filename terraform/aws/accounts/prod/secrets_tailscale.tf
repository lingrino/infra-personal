resource "tailscale_oauth_client" "terraform_cloud" {
  description = "terraform-cloud"
  scopes      = ["all"]
}

ephemeral "aws_secretsmanager_secret_version" "tailscale" {
  secret_id = "tailscale/keys/terraform-cloud"
}

resource "aws_secretsmanager_secret" "tailscale_keys_terraform_cloud" {
  name = "tailscale/keys/terraform-cloud"

  tags = {
    Name = "tailscale/keys/terraform-cloud"
  }
}

resource "aws_secretsmanager_secret_version" "tailscale_keys_terraform_cloud" {
  secret_id = aws_secretsmanager_secret.tailscale_keys_terraform_cloud.id
  secret_string = jsonencode({
    TAILSCALE_OAUTH_CLIENT_ID     = tailscale_oauth_client.terraform_cloud.id,
    TAILSCALE_OAUTH_CLIENT_SECRET = tailscale_oauth_client.terraform_cloud.key,
  })
}

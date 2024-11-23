resource "aws_secretsmanager_secret" "tailscale_keys_terraform_cloud" {
  name = "tailscale/keys/terraform-cloud"

  tags = {
    Name = "tailscale/keys/terraform-cloud"
  }
}

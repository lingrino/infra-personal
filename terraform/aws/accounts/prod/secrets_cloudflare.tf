resource "aws_secretsmanager_secret" "cloudflare_keys_terraform_cloud" {
  name = "cloudflare/keys/terraform-cloud"

  tags = {
    Name = "cloudflare/keys/terraform-cloud"
  }
}

resource "aws_secretsmanager_secret_version" "cloudflare_keys_terraform_cloud" {
  secret_id = aws_secretsmanager_secret.cloudflare_keys_terraform_cloud.id
  secret_string = jsonencode({
    CLOUDFLARE_API_TOKEN = cloudflare_api_token.terraform_cloud.value,
  })
}

resource "cloudflare_api_token" "terraform_cloud" {
  name = "terraform-cloud"

  policy {
    resources = {
      "com.cloudflare.api.account.*" = "*"
    }
    permission_groups = values(data.cloudflare_api_token_permission_groups.all.account)
  }

  policy {
    resources = {
      "com.cloudflare.api.account.zone.*" = "*"
    }
    permission_groups = values(data.cloudflare_api_token_permission_groups.all.zone)
  }
}

resource "tfe_variable" "cloudflare" {
  for_each = nonsensitive(jsondecode(aws_secretsmanager_secret_version.cloudflare_keys_terraform_cloud.secret_string))

  variable_set_id = data.tfe_variable_set.all.id
  category        = "env"
  sensitive       = true

  key   = each.key
  value = each.value
}

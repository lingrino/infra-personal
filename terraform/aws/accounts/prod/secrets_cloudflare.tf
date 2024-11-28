#################################
### Create Tokens             ###
#################################
resource "aws_secretsmanager_secret" "cloudflare_keys_create_tokens" {
  name = "cloudflare/keys/create-tokens"

  tags = {
    Name = "cloudflare/keys/create-tokens"
  }
}

ephemeral "aws_secretsmanager_secret_version" "cloudflare_keys_create_tokens" {
  secret_id = aws_secretsmanager_secret.cloudflare_keys_create_tokens.id
}

#################################
### Terraform Cloud           ###
#################################
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

#################################
### Local                     ###
#################################
resource "aws_secretsmanager_secret" "cloudflare_keys_local" {
  name = "cloudflare/keys/local"

  tags = {
    Name = "cloudflare/keys/local"
  }
}

resource "aws_secretsmanager_secret_version" "cloudflare_keys_local" {
  secret_id = aws_secretsmanager_secret.cloudflare_keys_local.id
  secret_string = jsonencode({
    CLOUDFLARE_API_TOKEN = cloudflare_api_token.local.value,
  })
}

resource "cloudflare_api_token" "local" {
  name = "local"

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

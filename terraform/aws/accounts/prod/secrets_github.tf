#################################
### Terraform Cloud           ###
#################################
resource "aws_secretsmanager_secret" "github_keys_terraform_cloud" {
  name = "github/keys/terraform-cloud"

  tags = {
    Name = "github/keys/terraform-cloud"
  }
}

data "aws_secretsmanager_secret_version" "github_keys_terraform_cloud" {
  secret_id = aws_secretsmanager_secret.github_keys_terraform_cloud.id
}

#################################
### GitHub                    ###
#################################
resource "aws_secretsmanager_secret" "github_keys_goreleaser" {
  name = "github/keys/goreleaser"

  tags = {
    Name = "github/keys/goreleaser"
  }
}

data "aws_secretsmanager_secret_version" "github_keys_goreleaser" {
  secret_id = aws_secretsmanager_secret.github_keys_goreleaser.id
}

resource "github_actions_secret" "vaku_goreleaser" {
  for_each = nonsensitive(jsondecode(data.aws_secretsmanager_secret_version.github_keys_goreleaser.secret_string))

  repository      = "vaku"
  secret_name     = each.key
  plaintext_value = each.value
}

resource "github_actions_secret" "glen_goreleaser" {
  for_each = nonsensitive(jsondecode(data.aws_secretsmanager_secret_version.github_keys_goreleaser.secret_string))

  repository      = "glen"
  secret_name     = each.key
  plaintext_value = each.value
}

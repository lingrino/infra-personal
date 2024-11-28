#################################
### Terraform Cloud           ###
#################################
resource "aws_secretsmanager_secret" "github_keys_terraform_cloud" {
  name = "github/keys/terraform-cloud"

  tags = {
    Name = "github/keys/terraform-cloud"
  }
}

ephemeral "aws_secretsmanager_secret_version" "github_keys_terraform_cloud" {
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

ephemeral "aws_secretsmanager_secret_version" "github_keys_goreleaser" {
  secret_id = aws_secretsmanager_secret.github_keys_goreleaser.id
}

resource "github_actions_secret" "vaku_goreleaser" {
  repository      = "vaku"
  secret_name     = "GORELEASER_GITHUB_TOKEN"
  plaintext_value = jsondecode(ephemeral.aws_secretsmanager_secret_version.github_keys_goreleaser.secret_string)["GORELEASER_GITHUB_TOKEN"]
}

resource "github_actions_secret" "glen_goreleaser" {
  repository      = "glen"
  secret_name     = "GORELEASER_GITHUB_TOKEN"
  plaintext_value = jsondecode(ephemeral.aws_secretsmanager_secret_version.github_keys_goreleaser.secret_string)["GORELEASER_GITHUB_TOKEN"]
}
